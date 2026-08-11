package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"sync"
	"time"
)

const (
	listenAddr = "127.0.0.1:8091"
	cacheFile  = "/data/sky.json"
	maxRecords = 10
)

var fileMu sync.Mutex

type tokenRecord struct {
	XUserID       string `json:"x_user_id"`
	XSessionToken string `json:"x_session_token"`
	Path          string `json:"path"`
	CapturedAt    string `json:"captured_at"`
}

func main() {
	// 使用 GitHub API 作为上游，主机可由 GITHUB_API_HOST 环境变量覆盖
	githubHost := os.Getenv("GITHUB_API_HOST")
	if githubHost == "" {
		githubHost = "api.github.com"
	}
	// 可选的 GitHub token（用于私有接口或更高配额）
	githubToken := os.Getenv("GITHUB_TOKEN")

	target := &url.URL{Scheme: "https", Host: githubHost}
	proxy := httputil.NewSingleHostReverseProxy(target)

	// Preserve single-host director but set Host header to githubHost and optionally add auth
	originalDirector := proxy.Director
	proxy.Director = func(req *http.Request) {
		originalDirector(req)
		req.Host = githubHost
		// 确保 Accept 使用 GitHub v3+JSON
		if req.Header.Get("Accept") == "" {
			req.Header.Set("Accept", "application/vnd.github+json")
		}
		// 若提供了 GITHUB_TOKEN 且请求未携带 Authorization，则注入
		if githubToken != "" && req.Header.Get("Authorization") == "" {
			req.Header.Set("Authorization", "Bearer "+githubToken)
		}
	}

	proxy.ErrorHandler = func(w http.ResponseWriter, _ *http.Request, _ error) {
		http.Error(w, "github api unavailable", http.StatusBadGateway)
	}

	// 使用 ServeMux 来同时提供签名 API 与代理功能
	mux := http.NewServeMux()

	mux.HandleFunc("/api/sign", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
			return
		}
		signHandler(w, r)
	})

	mux.HandleFunc("/", func(w http.ResponseWriter, req *http.Request) {
		if req.URL.Path == "/account/ws" {
			if err := cachePair(req); err != nil {
				fmt.Fprintln(os.Stderr, "cache error:", err)
			}
		}
		proxy.ServeHTTP(w, req)
	})

	server := &http.Server{
		Addr:              listenAddr,
		Handler:           mux,
		ReadHeaderTimeout: 5 * time.Second,
		IdleTimeout:       30 * time.Second,
	}
	panic(server.ListenAndServe())

}

// signHandler 执行重签名、生成安装 manifest (plist)，并将产物写到 artifacts/ 目录。
// 返回 JSON: { "itms_url": "itms-services://?action=download-manifest&url=...", "manifest_url": "https://.../quan.plist", "manifest": "<plist>...</plist>" }
func signHandler(w http.ResponseWriter, r *http.Request) {
	// 触发重签脚本
	cmd := "/bin/bash"
	script := ".github/scripts/resign.sh"
	if _, err := os.Stat(script); err != nil {
		http.Error(w, "resign script not found", http.StatusInternalServerError)
		return
	}

	resign := exec.Command(cmd, script)
	// 继承环境，保证 CERT_ZIP_URL / CERT_PASSWORD 已在环境中（workflow 会提供）
	resign.Env = os.Environ()
	resign.Stdout = os.Stdout
	resign.Stderr = os.Stderr
	if err := resign.Run(); err != nil {
		http.Error(w, fmt.Sprintf("resign failed: %v", err), http.StatusInternalServerError)
		return
	}

	// 检查签名产物
	signed := "signed-quan.ipa"
	if _, err := os.Stat(signed); err != nil {
		http.Error(w, "signed ipa not found after resign", http.StatusInternalServerError)
		return
	}

	// 准备 artifacts 目录
	artdir := "artifacts"
	if err := os.MkdirAll(artdir, 0755); err != nil {
		http.Error(w, "failed to create artifacts dir", http.StatusInternalServerError)
		return
	}

	// 拷贝 signed ipa 到 artifacts/quan.ipa
	quanIPA := filepath.Join(artdir, "quan.ipa")
	if err := copyFile(signed, quanIPA); err != nil {
		http.Error(w, "failed to copy signed ipa: "+err.Error(), http.StatusInternalServerError)
		return
	}

	// 从 signed IPA 提取 Info.plist 到临时文件并读取元数据
	tmpDir, err := os.MkdirTemp("", "ipa-extract")
	if err != nil {
		http.Error(w, "failed to make temp dir", http.StatusInternalServerError)
		return
	}
	defer os.RemoveAll(tmpDir)

	unzipCmd := fmt.Sprintf("unzip -p %s 'Payload/*.app/Info.plist' > %s/Info.plist", signed, tmpDir)
	if err := exec.Command("/bin/bash", "-c", unzipCmd).Run(); err != nil {
		http.Error(w, "failed to extract Info.plist", http.StatusInternalServerError)
		return
	}
	plistPath := filepath.Join(tmpDir, "Info.plist")
	// use PlistBuddy to read keys (macOS)
	bundleIDBytes, _ := exec.Command("/usr/libexec/PlistBuddy", "-c", "Print :CFBundleIdentifier", plistPath).Output()
	bundleID := strings.TrimSpace(string(bundleIDBytes))
	bundleVerBytes, _ := exec.Command("/usr/libexec/PlistBuddy", "-c", "Print :CFBundleVersion", plistPath).Output()
	bundleVer := strings.TrimSpace(string(bundleVerBytes))
	appNameBytes, _ := exec.Command("/usr/libexec/PlistBuddy", "-c", "Print :CFBundleName", plistPath).Output()
	appName := strings.TrimSpace(string(appNameBytes))
	if appName == "" {
		appNameBytes, _ = exec.Command("/usr/libexec/PlistBuddy", "-c", "Print :CFBundleDisplayName", plistPath).Output()
		appName = strings.TrimSpace(string(appNameBytes))
	}

	// 生成 manifest plist 内容，ipa 将引用发布到 GitHub Pages 的固定 URL
	ipaURL := "https://sky-beta.github.io/ios/quan.ipa"
	plistContent := generateManifestPlist(appName, bundleID, bundleVer, ipaURL)

	plistPathOut := filepath.Join(artdir, "quan.plist")
	if err := os.WriteFile(plistPathOut, []byte(plistContent), 0644); err != nil {
		http.Error(w, "failed to write manifest plist: "+err.Error(), http.StatusInternalServerError)
		return
	}

	// 返回 itms url
	manifestURL := "https://sky-beta.github.io/ios/quan.plist"
	itms := "itms-services://?action=download-manifest&url=" + manifestURL

	resp := map[string]string{
		"itms_url":    itms,
		"manifest_url": manifestURL,
		"manifest":     plistContent,
	}
	w.Header().Set("Content-Type", "application/json")
	_ = json.NewEncoder(w).Encode(resp)
}

func copyFile(src, dst string) error {
	in, err := os.Open(src)
	if err != nil { return err }
	defer in.Close()
	out, err := os.Create(dst)
	if err != nil { return err }
	defer out.Close()
	if _, err := io.Copy(out, in); err != nil { return err }
	return out.Sync()
}

func generateManifestPlist(title, bundleID, bundleVersion, ipaURL string) string {
	// minimal manifest plist
	return fmt.Sprintf(`<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>items</key>
  <array>
    <dict>
      <key>assets</key>
      <array>
        <dict>
          <key>kind</key>
          <string>software-package</string>
          <key>url</key>
          <string>%s</string>
        </dict>
      </array>
      <key>metadata</key>
      <dict>
        <key>bundle-identifier</key>
        <string>%s</string>
        <key>bundle-version</key>
        <string>%s</string>
        <key>title</key>
        <string>%s</string>
      </dict>
    </dict>
  </array>
</dict>
</plist>`, ipaURL, bundleID, bundleVersion, title)
}
}

func cachePair(req *http.Request) error {
	userID := req.Header.Get("X-User-Id")
	sessionToken := req.Header.Get("X-Session-Token")

	// 如果两者都为空则不缓存
	if userID == "" && sessionToken == "" {
		return nil
	}

	rec := tokenRecord{
		XUserID:       userID,
		XSessionToken: sessionToken,
		Path:          req.URL.Path,
		CapturedAt:    time.Now().UTC().Format(time.RFC3339Nano),
	}
	return appendRecord(rec)
}

func appendRecord(rec tokenRecord) error {
	fileMu.Lock()
	defer fileMu.Unlock()

	var records []tokenRecord

	// 读取现有文件（如果存在）；若不存在则确保目录存在以便随后创建文件
	data, err := os.ReadFile(cacheFile)
	if err == nil {
		if len(data) > 0 {
			// 解析现有 JSON 文件为数组
			if err := json.Unmarshal(data, &records); err != nil {
				// 解析失败：不改写原文件，直接返回错误（上游请求仍会被转发）
				return fmt.Errorf("failed to parse existing cache file: %w", err)
			}
		}
	} else {
		if os.IsNotExist(err) {
			// 确保父目录存在，以便稍后创建文件
			dir := filepath.Dir(cacheFile)
			if dir != "." && dir != string(os.PathSeparator) {
				if mkerr := os.MkdirAll(dir, 0700); mkerr != nil {
					return fmt.Errorf("failed to create cache directory: %w", mkerr)
				}
			}
			// records stays empty; will create file when writing
		} else {
			return err
		}
	}

	// Append new record and trim oldest if necessary
	records = append(records, rec)
	if len(records) > maxRecords {
		records = records[len(records)-maxRecords:]
	}

	encoded, err := json.MarshalIndent(records, "", "  ")
	if err != nil {
		return err
	}

	tmp := cacheFile + ".tmp"
	if err := os.WriteFile(tmp, encoded, 0600); err != nil {
		return err
	}
	return os.Rename(tmp, cacheFile)
}
