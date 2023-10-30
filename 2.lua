function editData(A0_73, A1_74)
  gg.setVisible(false)
  gg.clearResults()
  qmnbv = A0_73[3].value or A0_73[3][1]
  qmnbt = A0_73[3].type or A0_73[3][2]
  qmnbn = A0_73[2].name or A0_73[2][1]
  gg.setRanges(A0_73[1].memory or A0_73[1][1])
  gg.searchNumber(qmnbv, qmnbt)
  gg.refineNumber(qmnbv, qmnbt)
  sz = gg.getResultCount()
  if sz == 0 then
    gg.toast(qmnbn .. "开启失败")
  else
    sl = gg.getResults(999999)
    for _FORV_5_ = 1, sz do
      pdsz = true
      for _FORV_9_ = 4, #A0_73 do
        if pdsz == true then
          pysz = {
            {}
          }
          pysz[1].address = sl[_FORV_5_].address + (A0_73[_FORV_9_].offset or A0_73[_FORV_9_][2])
          pysz[1].flags = A0_73[_FORV_9_].type or A0_73[_FORV_9_][3]
          szpy = gg.getValues(pysz)
          tzszpd = tostring(A0_73[_FORV_9_].lv or A0_73[_FORV_9_][1]):gsub(",", "")
          pyszpd = tostring(szpy[1].value):gsub(",", "")
          if tzszpd == pyszpd then
            pdjg = true
            pdsz = true
          else
            pdjg = false
            pdsz = false
          end
        end
      end
      if pdjg == true then
        szpy = sl[_FORV_5_].address
        for _FORV_9_ = 1, #A1_74 do
          xgsz = A1_74[_FORV_9_].value or A1_74[_FORV_9_][1]
          xgpy = szpy + (A1_74[_FORV_9_].offset or A1_74[_FORV_9_][2])
          xglx = A1_74[_FORV_9_].type or A1_74[_FORV_9_][3]
          xgdj = A1_74[_FORV_9_].freeze or A1_74[_FORV_9_][4]
          xg = {
            {
              address = xgpy,
              flags = xglx,
              value = xgsz
            }
          }
          if xgdj == true then
            xg[1].freeze = xgdj
            gg.addListItems(xg)
          else
            gg.setValues(xg)
          end
        end
        xgjg = true
      end
    end
    if xgjg == true then
      gg.toast(qmnbn .. "开启成功")
    else
      gg.toast(qmnbn .. "开启失败")
    end
  end
end

function editData(A0_75, A1_76)
  gg.setVisible(false)
  gg.clearResults()
  qmnbv = A0_75[3].value or A0_75[3][1]
  qmnbt = A0_75[3].type or A0_75[3][2]
  qmnbn = A0_75[2].name or A0_75[2][1]
  gg.setRanges(A0_75[1].memory or A0_75[1][1])
  gg.searchNumber(qmnbv, qmnbt)
  gg.refineNumber(qmnbv, qmnbt)
  sz = gg.getResultCount()
  if sz == 0 then
    gg.toast(qmnbn .. "开启失败")
  else
    sl = gg.getResults(999999)
    for _FORV_5_ = 1, sz do
      pdsz = true
      for _FORV_9_ = 4, #A0_75 do
        if pdsz == true then
          pysz = {
            {}
          }
          pysz[1].address = sl[_FORV_5_].address + (A0_75[_FORV_9_].offset or A0_75[_FORV_9_][2])
          pysz[1].flags = A0_75[_FORV_9_].type or A0_75[_FORV_9_][3]
          szpy = gg.getValues(pysz)
          tzszpd = tostring(A0_75[_FORV_9_].lv or A0_75[_FORV_9_][1]):gsub(",", "")
          pyszpd = tostring(szpy[1].value):gsub(",", "")
          if tzszpd == pyszpd then
            pdjg = true
            pdsz = true
          else
            pdjg = false
            pdsz = false
          end
        end
      end
      if pdjg == true then
        szpy = sl[_FORV_5_].address
        for _FORV_9_ = 1, #A1_76 do
          xgsz = A1_76[_FORV_9_].value or A1_76[_FORV_9_][1]
          xgpy = szpy + (A1_76[_FORV_9_].offset or A1_76[_FORV_9_][2])
          xglx = A1_76[_FORV_9_].type or A1_76[_FORV_9_][3]
          xgdj = A1_76[_FORV_9_].freeze or A1_76[_FORV_9_][4]
          xg = {
            {
              address = xgpy,
              flags = xglx,
              value = xgsz
            }
          }
          if xgdj == true then
            xg[1].freeze = xgdj
            gg.addListItems(xg)
          else
            gg.setValues(xg)
          end
        end
        xgjg = true
      end
    end
    if xgjg == true then
      gg.toast(qmnbn .. "开启成功")
    else
      gg.toast(qmnbn .. "开启失败")
    end
  end
end

function xqmnb(A0_77, A1_78)
  local L2_79, L3_80, L4_81, L5_82, L6_83, L7_84, L8_85, L9_86, L10_87, L11_88, L12_89, L13_90, L14_91, L15_92, L16_93, L17_94, L18_95
end

function SearchWrite(A0_96, A1_97)
  local L2_98, L3_99, L4_100, L5_101, L6_102, L7_103, L8_104, L9_105, L10_106, L11_107, L12_108, L13_109, L14_110, L15_111, L16_112, L17_113, L18_114
end

DWORD = gg.TYPE_DWORD
DOUBLE = gg.TYPE_DOUBLE
FLOAT = gg.TYPE_FLOAT
WORD = gg.TYPE_WORD
BYTE = gg.TYPE_BYTE
XOR = gg.TYPE_XOR
QWORD = gg.TYPE_QWORD
function Main()
  menu = gg.choice({
    "刷礼包+免资格（登陆界面开启）",
    "刷极光季毕业礼备用",
    "20倍速",
    "季节任务",
    "开先祖+向导",
    "云野传送",
    "场景变速",
    "无限能量",
    "退出脚本",
    "原地光翼",
    "点火吸蜡烛",
    "刷毕业头",
  }, nil, "回溯")
  if menu == 1 then
    HS1()
    Main()
  end
  if menu == 2 then
    HS2()
  end
  if menu == 3 then
    A5()
    --HS4()
  end
  if menu == 4 then
    HS5()
  end
  if menu == 5 then
    HSS()
    --HS7()
  end
  if menu == 6 then
    HS3()
  end
  if menu == 7 then
    HS7()
  end
  if menu == 8 then
    HS6()
  end
  if menu == 9 then
    Exit()
  end
  if menu == 10 then
    HSW()
  end
  if menu == 11 then
    HSB()
   
  end
  if menu == 12 then
    HSE()
  end
end

function HS1()
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber(":SNC", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(":SNB", gg.TYPE_BYTE)

gg.clearResults()
gg.searchNumber(":event_name", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(":event_namm", gg.TYPE_BYTE)

gg.clearResults()
gg.searchNumber(":npc_names", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(":npc_namee", gg.TYPE_BYTE)
gg.toast("氪金礼包修改成功～")

gg.clearResults()
gg.searchNumber(":SPASS", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(":SPAHZ", gg.TYPE_BYTE)
gg.toast("氪金礼包修改成功～")
     gg.setVisible(true)
     gg.clearResults()
      gg.setRanges(4)
      gg.searchNumber(":Sky-Test-com.tgc.sky.android.test.gold", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
      gg.searchNumber("", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
      gg.getResults(100)
      gg.editAll(":Sky-Test-com.tgc.sky.android.dev.gold ", gg.TYPE_BYTE)
      gg.toast("脚本开启成功，游戏已免资格")
      gg.clearResults()
        gg.clearResults()
  gg.setRanges(gg.REGION_C_DATA)
  gg.searchNumber("2.5", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
  gg.getResults(100)
  gg.editAll("3.5", gg.TYPE_FLOAT)
  gg.toast("修改成功")
  gg.clearResults()
end

function HSS()
  xianzu = {--直接添加即可
 {560443823,"全部先祖"},--不可删除
-- {代码,"先祖名字"},
--{414084241,"招手"},--例子,可删除
 --{4140842,"蝴蝶"},
{3666569351,"🏝晨岛拒绝先祖"},
{4249009249,"🏝晨岛快过来先祖"},
{1466879858,"☁云野打哈欠先祖"},
{64338276,"☁云野举蝴蝶先祖"},
{3063270590,"☁云野哈哈笑先祖"},
{2540775602,"☁云野鸟叫先祖"},
{1568825369,"☁云野举蜡烛先祖"},
{2851084244,"☁云野挥手先祖"},
{1060667581,"☁云野鼓掌先祖"},
{3881128326,"☁云野擦汗先祖"},
{4182042971,"🌊雨林哭泣先祖"},
{419578801,"🌊雨林你猜先祖"},
{1156673674,"🌊雨林下跪先祖"},
{2381086145,"🌊雨林跺脚先祖"},
{1464190897,"🌊雨林捉迷藏先祖"},
{3576552037,"🌊雨林害羞先祖"},
{3930381583,"🌊雨林发抖先祖"},
{1728053750,"🌊雨林鲸鱼先祖"},
 {4025945604,"极光季armwave"},
{2492441724,"极光季rhythmicclap"},
{3251817329,"极光季twirl"},
{4257024023,"极光季raisetheroof"},
{3307167098,"🛕霞谷自信先祖"},
{1942389483,"🛕霞谷鞠躬先祖"},
{3809307521,"🛕霞谷后空翻先祖"},
{2395108553,"🛕霞谷抱手先祖"},
{2859830090,"🛕霞谷欢呼先祖"},
{416637648,"🛕霞谷倒立先祖"},
{3768849824,"🛕霞谷鲲叫先祖"},
{1999438929,"🌋墓土敬礼先祖"},
{4155738138,"🌋墓土猥琐先祖"},
{2886532097,"🌋墓土勇敢先祖"},
{1060292445,"🌋墓土你看不见我先祖"},
{3630339793,"🌋墓土倒地先祖"},
{2159324587,"🌋墓土环顾先祖"},
{2797886853,"🏛禁阁漂浮先祖"},
{2041153668,"🏛禁阁气功先祖"},
{2017461200,"🏛禁阁鲲叫先祖"},
{3576140497,"🏛禁阁站姿先祖"},
{3594096657,"🏛禁阁祈祷先祖"},
{1380875331,"极光季向导1"},
{1397652950,"🛕破碎季向导"},
{1414430569,"表演季向导"},
{1431208188,"☁深渊季向导"},
{1447985807,"☁风行季向导"},
{1464763426,"☁小王子季向导"},
{1481541045,"☁重组季向导"},
{1531726807,"🌊梦想季向导"},
{1514949188,"🌊预言季向导"},
{1363950617,"🌊魔法季向导"},
{1347172998,"🌊圣岛季向导"},
 {414084241,"以下会数据损坏"},
{3270784407,"感恩季狐狸先祖"},
{3637782525,"感恩季节跳跃先祖"},
{1972794995,"感恩季敬礼先祖"},
{3811807379,"感恩季抱拳先祖"},
{3416766502,"感恩季功夫先祖"},
{1841001535,"感恩季举手先祖"},
{1880348208,"追光季背背先祖"},
{3143328229,"追光季转圈先祖"},
{1372682856,"追光季击掌先祖"},
{1543189191,"追光季螃蟹先祖"},
{3828216322,"追光季噤声先祖"},
{1375735318,"归属季蹦迪先祖"},
{627603397,"归属季花手先祖"},
{3921932554,"归属季礼花先祖"},
{3613216684,"归属季别走先祖"},
 {560443823,"归属季红耳机先祖"},
{391633837,"归属季背手先祖"},
{4162136220,"凛冬季跳舞先祖"},
{3379075209,"凛冬季杂技先祖"},
{2093468251,"凛冬季疑惑先祖"},
{3723728503,"凛冬季飞吻先祖"},
{669089267,"凛冬季绅士先祖"},
{1801995405,"凛冬季骑士先祖"},
{967947706,"魔法季瞌睡先祖"},
{2120182059,"魔法季惊吓先祖"},
{1251050323,"魔法季锤人先祖"},
{2248102924,"魔法季无奈先祖"},
{235271310,"魔法季学螃蟹先祖"},
{1996231227,"圣岛季水母先祖"},
{1179404396,"圣岛季抱手先祖"},
{3122155373,"圣岛季生气先祖"},
{2427814255,"圣岛季肚皮先祖"},
{970386689,"圣岛季发光先祖"},
{1295259432,"圣岛季爱心先祖"},
{3098835268,"预言季火先祖"},
{2560266987,"预言季风先祖"},
{1888998250,"预言季土先祖"},
{2326309241,"预言季水先祖"},
{416637648,"🛕霞谷倒立先祖"},
{3768849824,"🛕霞谷鲲叫先祖"},
{1999438929,"🌋墓土敬礼先祖"},
{4155738138,"🌋墓土猥琐先祖"},
{2886532097,"🌋墓土勇敢先祖"},
{1060292445,"🌋墓土你看不见我先祖"},
{3630339793,"🌋墓土倒地先祖"},
{2159324587,"🌋墓土环顾先祖"},
{2797886853,"🏛禁阁漂浮先祖"},
{2041153668,"🏛禁阁气功先祖"},
{2017461200,"🏛禁阁鲲叫先祖"},
{3576140497,"🏛禁阁站姿先祖"},
{3594096657,"🏛禁阁祈祷先祖"},
--【以下会损坏数据】
-- {1972794995,"感恩季敬礼先祖"},
-- {3811807379,"感恩季抱拳先祖"},
-- {3416766502,"感恩季功夫先祖"},
-- {1841001535,"感恩季举手先祖"}
-- {1414283474,"感恩季毕业先祖"}
-- {1880348208,"追光季背背先祖"}
-- {638820386,"追光季雨伞先祖"}
-- {3143328229,"追光季转圈先祖"}
-- {1372682856,"追光季击掌先祖"}
-- {1543189191,"追光季螃蟹先祖"}
-- {3828216322,"追光季噤声先祖"}
-- {1431061093,"追光季毕业先祖"}
-- {1375735318,"归属季蹦迪先祖"}
-- {627603397,"归属季花手先祖"}
-- {3921932554,"归属季礼花先祖"}
-- {3613216684,"归属季别走先祖"}
-- {560443823,"归属季摸头先祖"}
-- {391633837,"归属季背手先祖"}
-- {1313617760,"归属季毕业先祖"}
-- {4162136220,"凛冬季跳舞先祖"}
-- {3379075209,"凛冬季杂技先祖"}
-- {2093468251,"凛冬季疑惑先祖"}
-- {3723728503,"凛冬季飞吻先祖"}
-- {669089267,"凛冬季绅士先祖"}
-- {1801995405,"凛冬季骑士先祖"}
-- {1330395379,"凛冬季毕业先祖"}
-- {967947706,"魔法季瞌睡先祖"}
-- {2120182059,"魔法季惊吓先祖"}
-- {1251050323,"魔法季锤人先祖"}
-- {2248102924,"魔法季无奈先祖"}
-- {235271310,"魔法季学螃蟹先祖"}
-- {651520861,"魔法季毕业先祖"}
-- {1996231227,"圣岛季水母先祖"}
-- {1179404396,"圣岛季抱手先祖"}
-- {3122155373,"圣岛季生气先祖"}
-- {2427814255,"圣岛季肚皮先祖"}
-- {970386689,"圣岛季发光先祖"}
-- {1295259432,"圣岛季爱心先祖"}
-- {3098835268,"预言季火先祖"}
-- {2560266987,"预言季风先祖"}
-- {1888998250,"预言季土先祖"}
-- {2326309241,"预言季水先祖"}
-- 



 }
gg.clearList()
gg.setVisible(false)
gg.clearResults()
gg.setRanges(gg.REGION_C_DATA)
gg.searchNumber("15000",16,false,gg.SIGN_EQUAL,0,-1)
result = gg.getResults(1)
Start = 0x1000000000
End = result[1].address
gg.toast("初始内存范围获取成功")
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber("414084241" ,gg.TYPE_QWORD, false, gg.SIGN_EQUAL,Start,End)
resultCount = gg.getResultCount()
if resultCount < 8 then
  gg.toast("开先祖获取失败,请确定 指路先祖(晨岛)是否完成！或重启游戏或手机！")
  os.exit()
  else
  kg = 1
  result = gg.getResults(resultCount)
  end
function gguipd()
::ks::
while true do
if gg.isVisible(true) then
gg.setVisible(false)
break return
end
gg.sleep(800)
end
end
function kxz(xianzu)
tmp={}
for k,v in pairs(xianzu)do
  tmp[#tmp + 1] = {}
  tmp[#tmp] = xianzu[k][2]
  end
  local menu_pt = gg.multiChoice(tmp, nil, "🌸请选择你要解锁的先祖🌸\n🌸务必解锁(晨岛)伸手先祖🌸")
  gg.toast("点击GG开始")
  if menu_pt[1] then 
  for k,v in pairs(xianzu)do
   ::ks::
  gguipd()
  i=k
  menu=gg.choice({
      "下一个",
      "退出"
    }, nil, "🌸开一个记得去点一次先祖！")
    if menu == 2 then os.exit()
    elseif menu~=1 then goto ks end
  gg.setValues({{address =result[2].address, flags = 32, value =  xianzu[i][1]}})
  gg.setValues({{address =result[#result].address, flags = 32, value =  xianzu[i][1]}})
  gg.toast("当前解锁:"..xianzu[i][2])
  end
  else
for k,v in pairs(xianzu)do
if menu_pt[k] then
  ::ks::
  gguipd()
  i=k
  menu=gg.choice({
      "下一个",
      "退出"
    }, nil, "🌸️开一个记得去点一次先祖！")
    if menu == 2 then os.exit()
    elseif menu~=1 then goto ks end
  gg.setValues({{address =result[2].address, flags = 32, value =  xianzu[i][1]}})
  gg.setValues({{address =result[#result].address, flags = 32, value =  xianzu[i][1]}})
  gg.toast("当前解锁:"..xianzu[i][2])
  
  end
  end
  end
  end
kxz(xianzu)
end


function HSB()
  menu1 = gg.multiChoice({
	"1. 点蜡烛",
	"2. 炸花",
	"3. 吸蜡烛",
	"0. 返回主页"
  }, nil, "点/吸蜡烛")
  if menu1 == nil then else
  if menu1[1] == true then j1() end
  if menu1[2] == true then hong() end
  if menu1[3] == true then zgxs() end
  if menu1[4] == true then HOME() end end
end

--点蜡烛
function j1()
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber("1;-1,027,080,192;2~608::25" , gg.TYPE_DWORD)
gg.refineNumber("-1,027,080,192", gg.TYPE_DWORD)
p = gg.getResultCount()
q = gg.getResults(p)

for i = 1,p do
          local  r = {}
			r[i] = {}
			        r[i].address = q[i].address - 56
				    r[i].flags = 16
					r[i].value = "999999"
gg.setValues(r)

end
gg.clearResults()
  
    gg.toast("点蜡烛，修改成功")
end
function zgxs()
    gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber("1;-1,027,080,192;2~608::25" , gg.TYPE_DWORD)
gg.refineNumber("-1,027,080,192", gg.TYPE_DWORD)
p = gg.getResultCount()
q = gg.getResults(p)

for i = 1,p do
          local  r = {}
			r[i] = {}
			        r[i].address = q[i].address - 56
				    r[i].flags = 16
					r[i].value = "999999"
gg.setValues(r)

end
gg.clearResults()
  
    gg.toast("点蜡烛，修改成功")
end

--吸蜡烛
function zgxs()
	gg.clearResults();
	gg.setRanges(4)
	gg.searchNumber("-842203136", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
	local num = gg.getResultCount()
	local xh = gg.getResults(num)
	
	for k, v in pairs(xh) do
		v.isMatch = true
	end
	
	local shtmp = {}
	for i, v in ipairs(xh) do
		shtmp[#shtmp+1] = {}
		shtmp[#shtmp].address = v.address - 12
		shtmp[#shtmp].flags = gg.TYPE_FLOAT
	end
	
	shtmp = gg.getValues(shtmp)
	for i, v in ipairs(shtmp) do
		if "" .. v.value ~= "3.5" then
			xh[i].isMatch = false
		end
	end
	
	local shdata = {}
	for i, v in ipairs(xh) do
		if (v.isMatch) then
    		shdata[#shdata+1] = v.address - 12
		end
	end
	
	shsl = #shdata
	local shqd = {}
	for i = 1, shsl do
		shqd[#shqd+1] = {}
		shqd[#shqd].address = shdata[i]
		shqd[#shqd].flags = gg.TYPE_FLOAT
		shqd[#shqd].value = 9999
	end
	
	gg.setValues(shqd)
	gg.clearResults()
	gg.toast("🥜吸溜了".. shsl .."烛光🥜")
end 
function hong()
    gg.setVisible(false)
    gg.clearResults()
    gg.setRanges(gg.REGION_C_ALLOC)
    gg.searchNumber("-100", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0x7000000000, 0xffffffffff)
    local num = gg.getResultCount(1)
    if num >= 1 then
        local jq = gg.getResults(num)
        local tmp = {}
        for k, v in pairs(jq) do
            tmp[#tmp + 1] = {}
            tmp[#tmp].address = v.address - 8
            tmp[#tmp].flags = gg.TYPE_DWORD
        end
        tmp = gg.getValues(tmp)
        for k, v in pairs(tmp) do
            if v.value == 1 then
                jq[1] = tmp[k]
                break
            end
        end
        local dz = jq[1].address
        
        nldz = dz - 48
    else
        gg.toast("获取能量地址失败")
    end

    gg.clearResults()
      local pianyi = {}
    for i=1,320 do
	pianyi[i] = {}
	pianyi[i].address = nldz + i * 448
	pianyi[i].flags = gg.TYPE_FLOAT
	pianyi[i].value = '1'
	pianyi[i].freeze = true
	gg.addListItems(pianyi)
    gg.clearResults()
    end
        gg.toast("点蜡烛成功")
    
    GG=1
    
    gg.setVisible(false)
    gg.clearResults()
    gg.setRanges(gg.REGION_C_ALLOC)
    gg.searchNumber("300", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0x7000000000, 0xffffffffff)
    local num = gg.getResultCount(1)
    if num >= 1 then
        local zh = gg.getResults(num)
        local tmp = {}
        for k, v in pairs(zh) do
            tmp[#tmp + 1] = {}
            tmp[#tmp].address = v.address - 4
            tmp[#tmp].flags = gg.TYPE_DWORD
        end
        tmp = gg.getValues(tmp)
        for k, v in pairs(tmp) do
            if v.value == 3 then
                zh[1] = tmp[k]
                break
            end
        end
        local dz = zh[1].address
        
        zdh = dz + 4
    else
        gg.toast("获取能量地址失败")
    end

    gg.clearResults()
      local pianyi = {}
    for i=1,245 do
	pianyi[i] = {}
	pianyi[i].address = zdh + i * 8
	pianyi[i].flags = gg.TYPE_FLOAT
	pianyi[i].value = '0'
	pianyi[i].freeze = true
	gg.addListItems(pianyi)
    gg.clearResults()
    
        
    end
    GG=1
    gg.toast("炸花成功")
gg.setVisible(true)
end

function HS2()
FX="Main"
qi=gg.choice({
"一键季节任务",
"原地向导",
"刷黄蜡烛",
"刷礼包",
"返回"
},nil,"")
if qi == 1 then shualb() end
if qi == 2 then danscd() end
if qi == 3 then shuajl() end
if qi == 4 then zhuanb() end
if qi == 5 then Maina() end
end

function shuajl() 
gg.clearResults()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SP",1)
end
function Maina()
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":global_",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.searchNumber(":season_",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.alert("打开商店即可购买\t部分礼包需要传送去办公室或女巫派对")
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber(":SNC", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll(":SNB", gg.TYPE_BYTE)

gg.clearResults()
end
function shualb()
 gg.searchNumber("7037807", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
gg.processResume()
revert = gg.getResults(100, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll("0", gg.TYPE_DWORD)
gg.processResume()
gg.processResume()
end

function danscd()
gg.alert("先开启一件季节任务后再刷")
FX="lzlb"
ds = gg.choice({
"极光季",
"破碎季",
"表演季",
"深渊季",
"风行季",
"小王子季",
"重组季",
"梦想季",
"预言季",
"魔法季",
"圣岛季",
"TGC斗篷",
"新春礼包",
"跷跷板",
"茶座",
"海螺",
"海洋斗篷",
"彩虹花",
"彩虹头",
"小王子围巾",
"狐狸背饰",
"小王子绿大衣",
"黄伞",
"兔子头",
"枯树枝",
"万圣裙",
"万圣杀马特头",
"南瓜背饰",
"返回主页",
},nil,"")

if ds == 1 then dans1() end--01
if ds == 2 then dans2() end--07
if ds == 3 then dans3() end--08
if ds == 4 then dans4() end--09
if ds == 5 then dans5() end--13
if ds == 6 then dans6() end--14
if ds == 7 then dans7() end--15
if ds == 8 then dans8() end--16
if ds == 9 then dans9() end--17
if ds == 10 then dans10() end--18
if ds == 11 then dans11() end--19
if ds == 12 then dans12() end--20
if ds == 13 then dans13() end--21
if ds == 14 then dans14() end--22
if ds == 15 then dans15() end--23
if ds == 16 then dans16() end--24
if ds == 17 then dans17() end--25
if ds == 18 then dans18() end--27
if ds == 19 then dans19() end--28
if ds == 20 then dans20() end--29
if ds == 21 then dans21() end--30
if ds == 22 then dans22() end--32
if ds == 23 then dans23() end--33
if ds == 24 then dans24() end--35
if ds == 25 then dans25() end--36
if ds == 26 then dans26() end--37
if ds == 27 then dans27() end--38
if ds == 28 then dans28() end--39
if ds == 29 then Main() end
end

function dans1()--01
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap16", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans2()--07
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap15", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans3()--08
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap14", 1)
gg.setVisible(false)
gg.clearResults()
end
function dans4()--09
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap13", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans5()--13
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap12", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans6()--14
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap11", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans7()--15
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap10", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans8()--16
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap09", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans10()--18
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap08", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans11()--19
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap07", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans12()--20
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber(":questap17", 1, false, gg.SING_EQUAL, 0, -1)
gg.getResults(10000)
gg.editAll(":questap06", 1)
gg.setVisible(false)
gg.clearResults()
end

function dans13()--21
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC01",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans14()--22
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC22",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans15()--23
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC23",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans16()--24
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC24",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans17()--25
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC25",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans18()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC27",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans19()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC28",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans20()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC29",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans21()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC30",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans22()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC32",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans23()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC33",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans24()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC35",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans25()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC36",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans26()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC37",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans27()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC38",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
end

function dans28()
gg.setRanges(16384)
gg.searchNumber(":SPASS",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll("0",1)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber(":SPASSR",1,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(9999)
gg.editAll(":SNC39",1)
gg.alert("点击商店再关闭商店的瞬间会出现一个？号商品,需要手速快点击它然后购买再去衣柜查看即可")
  editData({
    {
      memory = gg.REGION_C_ALLOC
    },
    {name = "变速20"},
    {
      value = 1023969417,
      type = DWORD
    },
    {
      lv = 1,
      offset = -8,
      type = DWORD
    }
  }, {
    {
      value = 20,
      offset = 16,
      type = FLOAT,
      freeze = true
    }
  })
  gg.clearResults()
  gg.toast("打开商店购买")
  gg.clearResults()
end



function HS3()
  SN = gg.choice({
    "禁阁终点",
    "办公室",
    "音乐商店",
    "伊甸献祭",
    "星光大道",
    "万圣节地图",
    "任天堂地图",
    "获取在线登录",
    "返回主页"
  }, nil, "根据需要传送的地图修改")
  if SN == 1 then
    HJ1()
  end
  if SN == 2 then
    HJ2()
  end
  if SN == 3 then
    HJ3()
  end
  if SN == 4 then
    HJ4()
  end
  if SN == 5 then
    HJ5()
  end
  if SN == 6 then
    HJ6()
  end
  if SN == 7 then
    HJ7()
  end
  if SN == 8 then
    HJ8()
  end
  if SN == 9 then
    HJ9()
  end
  FX1 = 0
end

function HJ1()
   gg.clearResults()
	 gg.setRanges(4)
	 gg.searchNumber(":Prairie_ButterflyFields", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(9999)
	 gg.editAll(":NightEnd", gg.TYPE_BYTE)
	 gg.toast("开图成功，进入云野即可到达终点")
	 gg.clearResults()
end

function HJ2()
   gg.clearResults()
	 gg.setRanges(4)
	 gg.searchNumber(":Prairie_ButterflyFields", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(9999)
	 gg.editAll(":TGCOffice", gg.TYPE_BYTE)
	 gg.toast("开图成功，进入云野即可进入办公室")
	 gg.clearResults()
end

function HJ3()
   gg.clearResults()
	 gg.setRanges(4)
	 gg.searchNumber(":Prairie_ButterflyFields", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(9999)
	 gg.editAll(":SunsetVillage_MusicShop", gg.TYPE_BYTE)
	 gg.toast("开图成功，进入云野即可进入音乐商店")
	 gg.clearResults()
end

function HJ4()
   gg.clearResults()
	 gg.setRanges(4)
	 gg.searchNumber(":Prairie_ButterflyFields", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(9999)
	 gg.editAll(":StormEnd", gg.TYPE_BYTE)
	 gg.toast("开图成功，进入云野即可进入伊甸")
	 gg.clearResults()
end

function HJ5()
   gg.clearResults()
	 gg.setRanges(4)
	 gg.searchNumber(":Prairie_ButterflyFields", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(9999)
	 gg.editAll(":CandleSpaceEnd", gg.TYPE_BYTE)
	 gg.toast("开图成功，进入云野即可进入星光大道")
	 gg.clearResults()
end

function HJ6()
   gg.clearResults()
	 gg.setRanges(4)
	 gg.searchNumber(":Prairie_ButterflyFields", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(9999)
	 gg.editAll(":Event_DaysOfMischief", gg.TYPE_BYTE)
	 gg.toast("开图成功，进入云野即可进入万圣节地图")
	 gg.clearResults()
end

function HJ7()
   gg.clearResults()
	 gg.setRanges(4)
	 gg.searchNumber(":Prairie_ButterflyFields", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(9999)
	 gg.editAll(":Nintendo_CandleSpace", gg.TYPE_BYTE)
	 gg.toast("开图成功，进入云野即可马里奥地图")
	 gg.clearResults()
end

function HJ8()
if gg.getTargetInfo()["versionCode"]>=213670 then
  typy=4
  typy1=0xA60
  --0x2C=0x2C
 else
  typy=0
  typy1=0xA50
  --0x2C=0x2C
end
if cho==nil or cho==1 then range=4 gg.toast("普通模式") else range=gg.REGION_OTHER gg.toast("备用模式") end
function Search(num1,flag1,pianyi1,num2,flag2,pianyi2)--鎼滅储鏁板€ 
  gg.setVisible(false)
  gg.clearResults()
  gg.searchNumber(tostring(num1),flag1)
  local resCount = gg.getResultCount()
  if resCount ~= 0 then
    local result = gg.getResults(resCount)
    local tmp = {}
    for i, v in ipairs(result) do
      tmp[#tmp + 1] = {address = v.address + pianyi1, flags = flag2}
    end
    tmp = gg.getValues(tmp)
    for i, v in ipairs(tmp) do
      if v.value == num2 then
        tmp = tmp[i].address + pianyi2
        return tmp
      end
    end
  end
  return 0
end
function getset_core()
  set_core=Search("1,023,969,417",4,-0x8,1,4,0x18+8)+typy1
  gg.addListItems({{address=set_core,flags=16}})
  --(4,"1,023,969,417",4,"-0x8",4,"1","0x18","閫熷害鏍稿績鍒濆鍖 ")
end

function getinfomat()
user_agent=""
gg.setVisible(false)
gg.clearResults()
gg.setRanges(range)
gg.searchNumber(":set_app_badge_number",1)
gg.searchNumber(":s",1)
local res=gg.getResults(50)
local addrin1
local bddr3
gg.clearResults()
for i=1,#res do
local addr=gg.getValues({{address=res[i].address-8,flags=32}})[1].value
if gg.getValues({{address=addr,flags=4}})[1].value~=0 then
addrin1=addr
bddr3=gg.getValues({{address=res[i].address-0x10,flags=32}})[1].value
end
end
local b={}
local uagd=gg.getValues({{address=addrin1+0x10,flags=32}})[1].value+0x14
for i=1,130 do
b[i]={address=uagd+i-1,flags=1}
end
b=gg.getValues(b)
for i=1,130 do
if b[i].value~=0 then user_agent=user_agent..string.char(b[i].value) 
--gg.copyText(user_agent)  user_agent="Sky-Test-0/0.18.5.198000(XiaomiM2012K11C;android30.0.0;zh)"
else break end
end
addrin1=addrin1+0x28
b={}
for i=1,500 do
b[i]={address=addrin1+(i-1)*8,flags=32}
end
b=gg.getValues(b)
local c={}
for i=1,#b do
c[i]={address=b[i].value+0x38,flags=32}
end
c=gg.getValues(c)
for i=1,#c do
if c[i].value==bddr3 then
htpwhere[getsktr(b[i].value+0x48)]=b[i].value+0xC
end
end
end


function getlocalinfo()
local str=""
local b={}
for i=1,32 do
b[i]={address=set_core-0x2C+i+1,flags=1}
end
b=gg.getValues(b)
if b[1].value==0 and b[2].value==0 then return end
for i=1,#b do if b[i].value<0 then b[i].value=b[i].value+256 
end str=str..string.format("%02x",b[i].value)end
return str
end

function tgc_loginid(str)  --鑾峰彇璐﹀彿淇℃伅str灏辨槸user_id鍜宻ession
--gg.copyText(str)
local tab={1,33}
for j=1,2 do i=tab[j] tab[j]=str:sub(i,i+7)..""..str:sub(i+8,i+11)..""..str:sub(i+12,i+15)..""..str:sub(i+16,i+19)..""..str:sub(i+20,i+31) end
if #str~=128 then tab[3]=string.rep("0",64) else tab[3]=str:sub(65,-1) end
return tab
end

function localuser()   --鑾峰彇璐﹀彿淇℃伅
local tab=tgc_loginid(getlocalinfo())
user_id=tab[1]
session=tab[2]:gsub("","")
end
function Search3(sz,lx,gs)
  gg.clearResults()
  gg.searchNumber(tostring(sz),lx)
  if gg.getResultCount()==0 then
    return 0
   elseif gs==0 then
    res={}
    res=gg.getResults(gg.getResultCount())
    tmp=res[gg.getResultCount()].address
    return tmp
   else
    res={}
    res=gg.getResults(gg.getResultCount())
    tmp=res[gs].address
    return tmp
  end
end

getset_core()
getinfomat()
localuser()
Ranges=4
gg.clearResults()
gg.setRanges(range)
Core=Search3(":UnnamedSocket",1,1)+0x618
fwq={}
txt=""
if Core~=0 then
  for i=1,33 do
    fwq[i]={address=Core-1+i,flags=1}
    fwq=gg.getValues(fwq)
    if fwq[i].value==0 then
      break
     else
      txt=txt..string.char(fwq[i].value)
    end
  end
end
if txt=="beta.radiance.thatgamecompany.com" then
  pd="在线|测试服|"
 elseif txt=="x-6jr.pages.dev" then
  pd="在线|测试服|"
 elseif txt=="live.radiance.thatgamecompany.com" then
  pd="在线|国际服|"
end
--[[gg.setRanges(range)
gg.clearResults()
gg.searchNumber(":Beta",1)
if gg.getResultCount()~=0 then
  pd="娴嬭瘯鏈 "
end]]
gg.clearResults()
gg.setRanges(range)
gg.searchNumber(":HttpsClient Work",1)
gg.refineNumber(":H",1)
if gg.getResultCount()==0 then
  gg.alert("鑾峰彇澶辫触锛 ")
  os.exit()
else
  res=gg.getResults(1)
  xses={}
  for i=1,36 do
    xses[i]={address=res[1].address-0x40-1+i,flags=1}
  end
  xses=gg.getValues(xses)
  xsess=""
  for i=1,36 do
    xsess=xsess..string.char(xses[i].value)
  end
end
gg.clearResults()
gg.copyText(""..pd..user_id..""..session..""..user_agent..""..xsess)
print(""..pd..user_id..""..session..""..user_agent..""..xsess)
end

function HJ9()
  Main()
end


function HS5()
  gg.searchNumber("7037807", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
gg.processResume()
revert = gg.getResults(100, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll("0", gg.TYPE_DWORD)
gg.processResume()
gg.processResume()
end

function HS7()
  SN = gg.choice({
    "变速1",
    "变速5",
    "变速10",
    "变速15",
    "变速20",
    "退出脚本"
  }, nil, "场景变速")
  if SN == 1 then
    A1()
  end
  if SN == 2 then
    A2()
  end
  if SN == 3 then
    A3()
  end
  if SN == 4 then
    A4()
  end
  if SN == 5 then
    A5()
  end
  if SN == 6 then
    os.exit()
  end
  FX1 = 0
end

function A1()
  editData({
    {
      memory = gg.REGION_C_ALLOC
    },
    {name = "变速1"},
    {
      value = 1023969417,
      type = DWORD
    },
    {
      lv = 1,
      offset = -8,
      type = DWORD
    }
  }, {
    {
      value = 1,
      offset = 16,
      type = FLOAT,
      freeze = true
    }
  })
  gg.clearResults()
end

function A2()
  editData({
    {
      memory = gg.REGION_C_ALLOC
    },
    {name = "变速5"},
    {
      value = 1023969417,
      type = DWORD
    },
    {
      lv = 1,
      offset = -8,
      type = DWORD
    }
  }, {
    {
      value = 5,
      offset = 16,
      type = FLOAT,
      freeze = true
    }
  })
  gg.clearResults()
end

function A3()
  editData({
    {
      memory = gg.REGION_C_ALLOC
    },
    {name = "变速10"},
    {
      value = 1023969417,
      type = DWORD
    },
    {
      lv = 1,
      offset = -8,
      type = DWORD
    }
  }, {
    {
      value = 10,
      offset = 16,
      type = FLOAT,
      freeze = true
    }
  })
  gg.clearResults()
end

function A4()
  editData({
    {
      memory = gg.REGION_C_ALLOC
    },
    {name = "变速15"},
    {
      value = 1023969417,
      type = DWORD
    },
    {
      lv = 1,
      offset = -8,
      type = DWORD
    }
  }, {
    {
      value = 15,
      offset = 16,
      type = FLOAT,
      freeze = true
    }
  })
  gg.clearResults()
end

function A5()
  editData({
    {
      memory = gg.REGION_C_ALLOC
    },
    {name = "变速20"},
    {
      value = 1023969417,
      type = DWORD
    },
    {
      lv = 1,
      offset = -8,
      type = DWORD
    }
  }, {
    {
      value = 20,
      offset = 16,
      type = FLOAT,
      freeze = true
    }
  })
  gg.clearResults()
end

function HS6()
  gg.clearResults()
  gg.setRanges(gg.REGION_C_DATA)
  gg.searchNumber("2.5", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
  gg.getResults(100)
  gg.editAll("3.5", gg.TYPE_FLOAT)
  gg.toast("修改成功")
  gg.clearResults()
end  

function Exit()
  print("\r\n顾北出品必属精品~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n顾北出品必属精品~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n顾北出品必属精品~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n顾北出品必属精品~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n顾北出品必属精品~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" .. cs)
  os.exit()
end

function HSW()
	----原地光翼数组
LightChild_id={--光翼文本
    --遇境光翼翼
    {'l_CandleSpace_0'},
    --重生光翼
    {"l_Credits_0"},
    --晨岛5个
    {'l_Dawn_0'},{'l_Dawn_1'},{'l_Dawn_2'},{'l_Dawn_3'},{'l_Dawn_4'},
    --湖水的试炼
    {'l_Dawn_TrialsWater_0'},
    --️土地的试炼
    {'l_Dawn_TrialsEarth_0'},
    --空气的试炼
    {'l_Dawn_TrialsAir_0'},
    --火焰的试炼
    {'l_Dawn_TrialsFire_0'},
    --云野一图3个
    {'l_Prairie_ButterflyFields_0'},{'l_Prairie_ButterflyFields_1'},{'l_Prairie_ButterflyFields_2'},
    --云野右图2个
    {'l_Prairie_NestAndKeeper_0'},{'l_Prairie_NestAndKeeper_1'},
    --圣域群岛8个
    {'l_Prairie_Island_0'},{'l_Prairie_Island_1'},{'l_Prairie_Island_2'},{'l_Prairie_Island_3'},
    {'l_Prairie_Island_4'},{'l_Prairie_Island_5'},{'l_Prairie_Island_6'},{'l_Prairie_Island_7'},
    --云野左图2个
    {'l_Prairie_Cave_0'},{'l_Prairie_Cave_1'},
    --云野三塔5个
    {'l_Prairie_Village_0'},{'l_Prairie_Village_1'},{'l_Prairie_Village_2'},{'l_Prairie_Village_3'},{'l_Prairie_Village_4'},
    --八人门1个
    {'l_DayHubCave_0'},
    --雨林一图2个
    {'l_Rain_0'},{'l_Rain_1'},
    --大树屋2个
    {'l_Rain_BaseCamp_0'},{'l_Rain_BaseCamp_1'},
    --雨林二图4个
    {'l_RainForest_0'},{'l_RainForest_1'},{'l_RainForest_2'},{'l_RainForest_3'},
    --雨林副本2个
    {'l_RainShelter_0'},{'l_RainShelter_1'},
    --雨林地下副本4个
    {'l_Rain_Cave_0'},{'l_Rain_Cave_1'},{'l_Rain_Cave_2'},{'l_Rain_Cave_3'},
    --雨林水母图3个
    {'l_RainMid_0'},{'l_RainMid_1'},{'l_RainMid_2'},
    --雨林神殿1个
    {'l_RainEnd_0'},
    --雨林新图1个
    {'l_Skyway_0'},
    --霞谷一图3个
    {'l_Sunset_0'},{'l_Sunset_1'},{'l_Sunset_2'},
    --霞光城2个
    {'l_Sunset_Citadel_0'},{'l_Sunset_Citadel_1'},
    --飞行赛道2个
    {'l_Sunset_FlyRace_0'},{'l_Sunset_FlyRace_1'},
    --滑行赛道1个
    {'l_SunsetRace_0'},
    --赛道结尾2个
    {'l_SunsetEnd_0'},{'l_SunsetEnd_1'},
    --颁奖台1个
    {'l_SunsetColosseum_0'},
    --圆梦村3个
    {'l_SunsetVillage_0'},{'l_SunsetVillage_1'},{'l_SunsetVillage_2'},
    --隐士山谷2个
    {'l_Sunset_YetiPark_0'},{'l_Sunset_YetiPark_1'},
    --霞谷神殿1个
    {'l_SunsetEnd2_0'},
    --暮土破庙2个
    {'l_Dusk_0'},{'l_Dusk_1'},
    --失落方舟2个
    {'l_DuskOasis_0'},{'l_DuskOasis_1'},
    --暮土龙图6个
    {'l_DuskGraveyard_0'},{'l_DuskGraveyard_1'},{'l_DuskGraveyard_2'},
    {'l_DuskGraveyard_3'},{'l_DuskGraveyard_4'},{'l_DuskGraveyard_5'},
    --暮土沉船3个
    {'l_Dusk_CrabField_0'},{'l_Dusk_CrabField_1'},{'l_Dusk_CrabField_2'},
    --暮土古战场2个
    {'l_DuskMid_0'},{'l_DuskMid_1'},
    --暮土神庙1个
    {'l_DuskEnd_0'},
    --禁阁低层2个
    {'l_Night_0'},{'l_Night_1'},
    --禁阁地下室2个
    {'l_NightArchive_0'},{'l_NightArchive_1'},
    --禁阁高层4个
    {'l_Night2_0'},{'l_Night2_1'},{'l_Night2_2'},{'l_Night2_3'},
    --星漠3个
    {'l_NightDesert_0'},{'l_NightDesert_1'},{'l_NightDesert_2'},
    --暴风眼1图1个
    {'l_StormStart_0'},
    --暴风眼二图9个
    {'l_Storm_0'},{'l_Storm_1'},{'l_Storm_2'},{'l_Storm_3'},
    {'l_Storm_4'},{'l_Storm_5'},{'l_Storm_6'},{'l_Storm_7'},
    {'l_Storm_8'},
    --晨岛3先祖3光翼
    {'s_point'},{'s_nothanks'},{'s_come'},
    --云野8先祖10光翼
    {'s_yawn'},{'s_butterfly'},{'s_butterfly_02'},{'s_bird'},{'s_beacon'},{'s_wave'},{'s_wave_02'},{'s_laugh'},{'s_thumbsup'},{'s_wipe'},
    --雨林8先祖12光翼
    {'s_cry'},{'s_cry_02'},{'s_ohno'},{'s_ohno_02'},{'s_sorry'},{'s_pout'},{'s_pout_02'},{'s_seek'},{'s_seek_02'},{'s_shy'},{'s_cold'},{'s_whale'},
    --霞谷7先祖9光翼
    {'s_strong'},{'s_bow'},{'s_backflip'},{'s_proud'},{'s_proud_02'},{'s_cheer'},{'s_handstand'},{'s_handstand_02'},{'s_manta'},
    --暮土6先祖8光翼
    {'s_die'},{'s_brave'},{'s_brave_02'},{'s_sneaky'},{'s_sneaky_02'},{'s_salute'},{'s_scared'},{'s_lookaround'},
    --禁阁5先祖7光翼
    {'s_float'},{'s_force'},{'s_ghost'},{'s_ghost_02'},{'s_love'},{'s_pray'},{'s_pray_02'},
    --感恩季6先祖6光翼
    {'s_sass'},{'s_joy'},{'s_acknowledge'},{'s_kungfu'},{'s_sarcastic'},{'s_salutation'},
    --追光季6先祖6光翼
    {'s_carry'},{'s_lazycool'},{'s_tripleaxel'},{'s_doublefive'},{'s_crabvoice'},{'s_shh'},
    --归属季6先祖6光翼
    {'s_loopdance'},{'s_sparkler'},{'s_celebrate'},{'s_dontgo'},{'s_hairtousle'},{'s_wise'},
    --凛冬季6先祖6光翼
    {'s_dance'},{'s_juggle'},{'s_think'},{'s_kiss'},{'s_welcome'},{'s_respect'},
    --魔法季6先祖6光翼
    {'s_nod'},{'s_scare'},{'s_playfight'},{'s_shrug'},{'s_crabwalk'},{'s_doze'},
    --圣岛季6先祖6光翼
    {'s_jelly'},{'s_timid'},{'s_rally'},{'s_grumpy'},{'s_gratitude'},{'s_bellyscratch'},
    --预言季4先祖4光翼
    {'s_chestpound'},{'s_balance'},{'s_dustoff'},{'s_deepbreath'},
    --梦想季4先祖4光翼
    {'s_peek'},{'s_spintrick'},{'s_showdance'},{'s_bearhug'},
    --重组季6先祖6光翼
    {'s_eww'},{'s_chuckle'},{'s_marching'},{'s_bubbles'},{'s_tsktsk'},{'s_facepal'},
    --王子季6先祖6光翼
    {'s_beckon'},{'s_gloat'},{'s_stretch'},{'s_slouch'},{'s_sneeze'},{'s_scheme'},
    --飞行季4先祖4光翼
    {"s_nerdy"},{"s_babymanta"},{"s_pointup"},{"s_voila"},
    --深渊季4先祖4光翼
    {"s_anxious"},{"s_wait"},{"s_ouch"},{"s_evillaugh"},
    --表演季4先祖4光翼
    {"s_headbob"},{"s_duetdance"},{"s_handshake"},{"s_awww"},
    --破碎季4先祖4光翼
    {"s_darkvoidspace01"},{"s_lightvoidspace02"},{"s_darkvoidspace01"},{"s_lightvoidspace02"},
}


function getydgydz()
gg.setVisible(false)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber("1953656656",4)
local res=gg.getResults(500)
gg.clearResults()
local rab={}   rac={}
for i=1,#res do
rab[i]={address=res[i].address+0x4,flags=4}
rac[i]={address=res[i].address+0x1C,flags=4}
end
rab=gg.getValues(rab)
rac=gg.getValues(rac)
for i=1,#res do
if rab[i].value==27745 and rac[i].value==1051355819 then
ydgydz=res[i].address+0x11C
gg.addListItems({{address=ydgydz,flags=4,name="原地光翼地址"}})
break
end
end
end

--原地全部光翼
function ydgy()
getydgydz()
int2=ydgydz+0x28
for p = 1, #LightChild_id do
Switch = {{address = int2-0x58,flags = 4,value = 257}};
gg.setValues(Switch)
gg.sleep(50);gg.toast(' ' .. p .. '/' .. #LightChild_id .. '')
local Light = {}
for i = 1, 28 do
qwq = '.' .. LightChild_id[p][1]
Light[i]={address=int2 - 0x50 + i - 1,flags=1,value=qwq:byte(i) or 0}
Switch1 = {{address = int2,flags = 4,value = 5}}
Switch2 = {{address =int2+0x28,flags = 4,value = 65793}}
end
gg.setValues(Light);gg.setValues(Switch1);gg.setValues(Switch2)
end
Switch[1].value = 1;gg.setValues(Switch);gg.toast('光翼收集完成')
end
ydgy()
end
function HSE()
  gg.clearResults()
  gg.setRanges(gg.REGION_C_ALLOC)
  gg.searchNumber('3666569351',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.getResults(99)
  gg.editAll('414084241',gg.TYPE_QWORD)
  gg.toast('先解锁指路先祖节点')
  gg.clearResults()


  gg.clearResults()
  gg.setRanges(gg.REGION_C_ALLOC)
  gg.searchNumber('4249009249',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.getResults(99)
  gg.editAll('414084241',gg.TYPE_QWORD)
  gg.toast('开启成功')
  gg.clearResults()


  gg.clearResults()
  gg.setRanges(gg.REGION_C_ALLOC)
  gg.searchNumber('1466879858',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.getResults(99)
  gg.editAll('414084241',gg.TYPE_QWORD)
  gg.toast('开启成功')
  gg.clearResults()


  gg.clearResults()
  gg.setRanges(gg.REGION_C_ALLOC)
  gg.searchNumber('64338276',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.getResults(99)
  gg.editAll('414084241',gg.TYPE_QWORD)
  gg.toast('开启成功')
  gg.clearResults()

  gg.clearResults()
  gg.setRanges(gg.REGION_C_ALLOC)
  gg.searchNumber('3063270590',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
  gg.getResults(99)
  gg.editAll('414084241',gg.TYPE_QWORD)
  gg.toast('开启成功')
  gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2540775602',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('1568825369',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2851084244',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('1060667581',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()


gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('3881128326',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()



gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('4182042971',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()



gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('419578801',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()


gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('1156673674',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2381086145',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('1464190897',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('3576552037',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()


gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('3930381583',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('1728053750',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('3307167098',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()


gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('1942389483',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('3809307521',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2395108553',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()


gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2859860090',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('416637648',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('3768849824',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2859830090',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('1999438929',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('4155738138',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2886532097',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('1060292445',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('3630339793',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()


gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2159324587',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2797886853',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2041153668',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('2017461200',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('3576140497',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('开启成功')
gg.clearResults()

gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber('3594096657',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.searchNumber('',gg.TYPE_QWORD,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(99)
gg.editAll('414084241',gg.TYPE_QWORD)
gg.toast('"开启成功')

gg.clearResults()
   gg.clearResults()
	 gg.setRanges(4)
	 gg.searchNumber(":Prairie_ButterflyFields", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(9999)
	 gg.editAll(":CandleSpaceEnd", gg.TYPE_BYTE)
	 gg.toast('"已为您开启一键毕业，请前往云野直达兑换')
	 gg.clearResults()
end

while true do
  if gg.isVisible(true) then
    gg.setVisible(false)
    if G1 == 1 then
      MapA()
    elseif G2 == 1 then
      MapB()
    elseif G3 == 1 then
      MapC()
    elseif G4 == 1 then
      MapD()
    elseif G5 == 1 then
      MapE()
    elseif G6 == 1 then
      MapF()
    elseif G7 == 1 then
      MapG()
    elseif l1menu == 1 then
      L1()
    elseif l2menu == 1 then
      L2()
    elseif l3menu == 1 then
      L3()
    elseif l4menu == 1 then
      L4()
    elseif l5menu == 1 then
      L5()
    elseif l6menu == 1 then
      L6()
    elseif Dmenu == 1 then
      DMove()
    elseif Omenu == 1 then
      Other()
    elseif CanMenu == 1 then
      Candle()
    elseif BeMenu == 1 then
      Behind()
    elseif ZMmenu == 1 then
      ZMOve()
    elseif SecMenu == 1 then
      Sec()
    elseif g4Menu == 1 then
      g4()
    elseif Gmenu == 1 then
      GMove()
    elseif Tmenu == 1 then
      TMove()
    elseif MMenu == 1 then
      MoveMenu()
    elseif SeMenu == 1 then
      Season()
    elseif SDMenu == 1 then
      SD()
    elseif AcMenu == 1 then
      Action()
    else
      Main()
    end
  end
end
