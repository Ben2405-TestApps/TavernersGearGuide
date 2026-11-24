local ADDON,ns=...
local Core=_G.TavernersCore
if not Core then return end
local Data=ns and ns.GearData or {}
local DB=Core.Database:Register("TavernersGearGuideDB",{version=2,profileIndex=1},2)
local Profiles={
 WARRIOR={{"Arms PvP","Melee / PvP","Weapon damage > Strength > Stamina > Critical Strike"},{"Fury PvE","Melee / PvE","Weapon skill where relevant > Hit > Strength > Critical Strike"},{"Protection","Tank","Stamina > Defense > Armor > Strength > Hit"}},
 PALADIN={{"Holy","Healer","Healing power > Intellect > Mana per 5 > Spirit > Stamina"},{"Retribution","Melee / PvP","Weapon damage > Strength > Stamina > Critical Strike"},{"Protection","Tank","Stamina > Defense > Armor > Spell power / threat"}},
 HUNTER={{"Beast Mastery PvP","Ranged / PvP","Agility / Critical Strike for pressure; Stamina and pet durability for survival. The 8% hit figure is a PvE boss benchmark, not a PvP target."},{"Beast Mastery PvE","Ranged / PvE","Hit to 8% > Critical Strike > Haste > Agility > Intellect > Ranged Attack Power"},{"Marksmanship","Ranged","Ranged weapon DPS > Agility > Hit > Critical Strike > Attack Power"},{"Survival","Ranged / Weaving","Agility > Hit > Critical Strike > Attack Power"}},
 ROGUE={{"Combat","Melee / PvE","Weapon skill where relevant > Hit > Agility > Attack Power"},{"Subtlety PvP","Melee / PvP","Weapon damage > Agility > Stamina > Attack Power > Critical Strike"},{"Assassination","Melee","Agility > Attack Power > Hit > Critical Strike"}},
 PRIEST={{"Holy / Discipline","Healer","Healing power > Intellect > Mana per 5 > Spirit > Stamina"},{"Shadow PvP","Caster / PvP","Spell damage > Stamina > Shadow damage > Intellect"}},
 MAGE={{"Frost PvP","Caster / PvP","Spell damage > Stamina > Intellect > Spell Critical Strike"},{"Fire PvE","Caster / PvE","Spell hit > Fire spell damage > Spell Critical Strike > Intellect"},{"Arcane","Caster","Spell damage > Spell hit > Intellect > Spell Critical Strike"}},
 WARLOCK={{"Affliction","Caster","Spell damage > Spell hit > Stamina > Intellect"},{"Demonology PvP","Caster / PvP","Stamina > Spell damage > Intellect > Shadow damage"},{"Destruction","Caster","Spell hit > Spell damage > Spell Critical Strike > Intellect"}},
 DRUID={{"Feral Tank","Tank","Armor > Stamina > Agility > Defense / avoidance > Strength"},{"Feral DPS","Melee","Agility > Strength > Attack Power > Critical Strike"},{"Restoration","Healer","Healing power > Mana per 5 > Intellect > Spirit"},{"Balance","Caster","Spell damage > Spell hit > Intellect > Spell Critical Strike"}},
 SHAMAN={{"Elemental","Caster","Spell damage > Spell hit > Intellect > Spell Critical Strike"},{"Enhancement","Melee","Weapon damage > Agility > Strength > Hit > Critical Strike"},{"Restoration","Healer","Healing power > Mana per 5 > Intellect > Spirit"}}
}
local G={db=DB,data=Data}
function G:Class() local _,c=UnitClass("player"); return c or "WARRIOR" end
function G:Profile() local list=Profiles[self:Class()] or {}; if #list==0 then return nil end; if DB.profileIndex>#list then DB.profileIndex=1 end; return list[DB.profileIndex],#list end
function G:Next() local list=Profiles[self:Class()] or {}; if #list>0 then DB.profileIndex=DB.profileIndex%#list+1 end; if self.UI then self.UI:Refresh() end end
function G:Equipped() local out={}; for slot=1,19 do local link=GetInventoryItemLink("player",slot); if link then out[#out+1]=GetItemInfo(link) or link end end; return out end
function G:GetDashboardSummary() local p=self:Profile(); return p and p[1] or "No class profile" end
Core:RegisterModule("GearGuide",G)
local frame,content
local function text(parent,t,y,font) local fs=parent:CreateFontString(nil,"OVERLAY",font or "GameFontHighlight"); fs:SetPoint("TOPLEFT",8,y); fs:SetWidth(630); fs:SetJustifyH("LEFT"); fs:SetWordWrap(true); fs:SetText(t); return fs end
local function refresh()
 if not content then return end
 for _,v in ipairs(content.rows or {}) do v:Hide(); v:SetParent(nil) end; content.rows={}; local y=-5
 local function add(t,f) local v=text(content,t,y,f); content.rows[#content.rows+1]=v; y=y-v:GetStringHeight()-8 end
 local p,total=G:Profile(); local _,class=UnitClass("player")
 add((UnitName("player") or "Character").." • "..(class or "Unknown").." • Level "..UnitLevel("player"),"GameFontNormal")
 if p then add("PROFILE "..DB.profileIndex.."/"..total.." • "..p[1].." • "..p[2],"GameFontNormal"); add("STAT PRIORITY","GameFontNormal"); add(p[3]) end
 if class=="HUNTER" and Data.hunterBM then
  add("BEAST MASTERY HUNTER — PHASE 1 PRE-RAID","GameFontNormal"); add("Wowhead updated "..Data.hunterBM.updated..". "..Data.hunterBM.note)
  add(Data.hunterBM.pvpNote or "PvP priorities differ from PvE stat weights.")
  add("PET SCALING IN FOREVER","GameFontNormal")
  for _,v in ipairs(Data.hunterBM.petScaling or {}) do add(v) end
  add("ITEM REFERENCE","GameFontNormal")
  for _,item in ipairs(Data.hunterBM.items or {}) do add(item.slot.." — "..item.name.." ["..item.rank.."]","GameFontHighlight"); add("Source: "..item.source,"GameFontHighlightSmall") end
  add("RANGED WEAPONS","GameFontNormal")
  for _,item in ipairs(Data.hunterBM.ranged or {}) do add(item.rank..": "..item.name.." — "..item.source) end
  add("PVE ENCHANT REFERENCE","GameFontNormal")
  for _,v in ipairs(Data.hunterBM.enchants or {}) do add(v.slot..": "..v.name) end
  add("Wowhead gear planner: "..tostring(Data.links and Data.links.HUNTER or "not indexed"))
 end
 add("EQUIPPED GEAR","GameFontNormal"); local gear=G:Equipped(); for _,item in ipairs(gear) do add(item) end
 if #gear==0 then add("No equipped items could be read.") end
 add("Use ranks as a guide, not an automatic score. Check special effects, hit cap, set bonuses and your PvP requirements.")
 content:SetHeight(math.max(1,-y+20))
end
local function build()
 if frame then return end
 frame=CreateFrame("Frame","TavernersGearGuideFrame",UIParent); frame:SetSize(700,500); frame:SetPoint("CENTER"); frame:SetFrameStrata("DIALOG")
 frame:SetMovable(true); frame:EnableMouse(true); frame:RegisterForDrag("LeftButton"); frame:SetScript("OnDragStart",frame.StartMoving); frame:SetScript("OnDragStop",frame.StopMovingOrSizing)
 if frame.SetBackdrop then frame:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background",edgeFile="Interface/Tooltips/UI-Tooltip-Border",tile=true,tileSize=16,edgeSize=16,insets={left=4,right=4,top=4,bottom=4}}); frame:SetBackdropColor(.07,.05,.035,.97) end
 local title=text(frame,"|cffffd27aThe Taverners|r — Gear Guide",-18,"GameFontNormalLarge"); title:SetWidth(600)
 local close=CreateFrame("Button",nil,frame,"UIPanelCloseButton"); close:SetPoint("TOPRIGHT",-4,-4)
 local b=CreateFrame("Button",nil,frame,"UIPanelButtonTemplate"); b:SetSize(160,24); b:SetPoint("TOPLEFT",18,-48); b:SetText("Next build / spec"); b:SetScript("OnClick",function() G:Next() end)
 local r=CreateFrame("Button",nil,frame,"UIPanelButtonTemplate"); r:SetSize(110,24); r:SetPoint("LEFT",b,"RIGHT",8,0); r:SetText("Refresh gear"); r:SetScript("OnClick",refresh)
 local s=CreateFrame("ScrollFrame","TavernersGearGuideScroll",frame,"UIPanelScrollFrameTemplate"); s:SetPoint("TOPLEFT",18,-82); s:SetPoint("BOTTOMRIGHT",-36,18)
 content=CreateFrame("Frame",nil,s); content:SetSize(640,1); s:SetScrollChild(content)
end
G.UI={Toggle=function() build(); if frame:IsShown() then frame:Hide() else frame:Show(); refresh() end end,Refresh=refresh}
local ev=CreateFrame("Frame"); ev:RegisterEvent("PLAYER_LOGIN"); ev:SetScript("OnEvent",function() build(); refresh() end)
SLASH_TAVERNERSGEARGUIDE1="/tgear"; SLASH_TAVERNERSGEARGUIDE2="/tgg"; SlashCmdList=SlashCmdList or {}
SlashCmdList.TAVERNERSGEARGUIDE=function() G.UI:Toggle() end
