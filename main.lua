----------------
-- Config ------
----------------
local x, y = 0, -20         -- x & y positioning from the centre of the screen
local fontSize = 12         -- size of the font
local fontFlag = "OUTLINE"  -- font decoration ("OUTLINE", "THICKOUTLINE" or "MONOCHROME")

----------------

local addon, ns = ...
local playerName, _ = UnitName("player")
local _, class = UnitClass("player")
local colour1 = RAID_CLASS_COLORS[class].colorStr
local fontFamily = [[Interface\AddOns\SharedMedia_MyMedia\font\DejaWeb-Bold.ttf]]--"Interface\\AddOns\\Supt\\Roboto-Bold.ttf"
local timer

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("SPELL_UPDATE_CHARGES")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

local chargeDisplay = frame:CreateFontString(nil, "OVERLAY")
chargeDisplay:SetFont(fontFamily, fontSize, fontFlag)
chargeDisplay:SetPoint("TOP", UIParent, "TOP", x, y)
chargeDisplay:Hide()--SetText("|c" ..colour1.. (GetSpellCharges(20484) and GetSpellCharges(20484) or "nope") .. "|r")

local timeDisplay = frame:CreateFontString(nil, "OVERLAY")
timeDisplay:SetFont(fontFamily, math.ceil(fontSize/1.25), fontFlag)
timeDisplay:SetPoint("LEFT", chargeDisplay, "RIGHT", 0, 0)
timeDisplay:Hide()--SetText("|c" ..colour1.. (GetSpellCharges(20484) and GetSpellCharges(20484) or "nope") .. "|r")

--frame:SetAlpha(0)

local function resTimeUpdate()
  local charges, _, started, duration = GetSpellCharges(20484)
  local time = duration - (GetTime() - started)
  local m = math.floor(time / 60)
  local s = time % 60
  local timeStr = m..":".. string.format("%02d", s)

  chargeDisplay:SetText("|c" ..colour1..charges.."|r")
  timeDisplay:SetText("|c" ..colour1.."(" ..timeStr.. ")|r")
end

local function eventHandler(self, event, ...)
  if event == "ADDON_LOADED" then
    if ... == addon then
      print("|c"..colour1..addon.."|r loaded!")
      frame:UnregisterEvent("ADDON_LOADED")
    end
  else

    if GetSpellCharges(20484) then
      chargeDisplay:Show()
      timeDisplay:Show()
      timer = C_Timer.NewTicker(1, resTimeUpdate, nil)
    else
      if timer then 
        timer:Cancel()
      end
      chargeDisplay:Hide()--SetText("|c" ..colour1.. (GetSpellCharges(20484) and GetSpellCharges(20484) or "nope") .. "|r")
      timeDisplay:Hide()
    end
  end
end

frame:SetScript("OnEvent", eventHandler)
