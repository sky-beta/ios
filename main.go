package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
	"path/filepath"
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

	handler := http.HandlerFunc(func(w http.ResponseWriter, req *http.Request) {
		// If path is /account/ws, cache the header pair then proxy
		if req.URL.Path == "/account/ws" {
			if err := cachePair(req); err != nil {
				// 非致命：记录到 stderr，但继续转发请求并返回上游响应
				fmt.Fprintln(os.Stderr, "cache error:", err)
			}
		}
		// 对所有路径（包括 /account/ws）原样转发到上游并返回上游响应
		proxy.ServeHTTP(w, req)
	})

	server := &http.Server{
		Addr:              listenAddr,
		Handler:           handler,
		ReadHeaderTimeout: 5 * time.Second,
		IdleTimeout:       30 * time.Second,
	}
	panic(server.ListenAndServe())
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
