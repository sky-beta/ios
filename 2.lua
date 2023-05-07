gg.alert("Made by 鍙湪\n璇锋斁蹇冧娇鐢ㄦ湰鑾峰彇淇℃伅鑴氭湰锛孿n鑾峰彇鍒扮殑session淇℃伅鍦ㄩ€€鍑烘父鎴忎笉涔呭悗浼氳嚜鍔ㄥけ鏁圽n鍦ㄩ€€鍑虹櫥褰曟垨鑰呴噸鏂扮櫥褰曪紝session淇℃伅灏变細鍙榎n璇蜂笉鐢ㄦ媴蹇冭处鍙蜂俊鎭硠闇查棶棰 ")
cho=gg.alert("璇烽€夋嫨杩愯妯″紡\n涓嶉€夋嫨榛樿姝ｅ父妯″紡\n濡傛灉鍑虹幇澶嶅埗鍐呭涓虹┖鐧借灏濊瘯鍒囨崲妯″紡","姝ｅ父妯″紡","澶囩敤妯″紡")
if gg.getTargetInfo()["versionCode"]>=213670 then
  typy=4
  typy1=0xA60
  --0x2C=0x2C
 else
  typy=0
  typy1=0xA50
  --0x2C=0x2C
end
if cho==nil or cho==1 then range=4 gg.toast("姝ｅ父妯″紡") else range=gg.REGION_OTHER gg.toast("澶囩敤妯″紡") end
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
for j=1,2 do i=tab[j] tab[j]=str:sub(i,i+7).."-"..str:sub(i+8,i+11).."-"..str:sub(i+12,i+15).."-"..str:sub(i+16,i+19).."-"..str:sub(i+20,i+31) end
if #str~=128 then tab[3]=string.rep("0",64) else tab[3]=str:sub(65,-1) end
return tab
end

function localuser()   --鑾峰彇璐﹀彿淇℃伅
local tab=tgc_loginid(getlocalinfo())
user_id=tab[1]
session=tab[2]:gsub("-","")
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
if txt=="dev.radiance.thatgamecompany.com" then
  pd="鍐呮祴鏈 "
 elseif txt=="beta.radiance.thatgamecompany.com" then
  pd="娴嬭瘯鏈 "
 elseif txt=="live.radiance.thatgamecompany.com" then
  pd="鍥介檯鏈 "
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
gg.copyText("鐧诲綍"..pd..user_id.."涓 "..session.."涓 "..user_agent.."涓 "..xsess)
print("鐧诲綍"..pd..user_id.."涓 "..session.."涓 "..user_agent.."涓 "..xsess)