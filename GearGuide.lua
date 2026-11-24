local ADDON,ns=...
local Core=_G.TavernersCore
if not Core then return end
local Data=ns and ns.GearData or {}
local DB=Core.Database:Register("TavernersGearGuideDB",{version=2,profileIndex=1},2)
local Profiles={
 WARRIOR={{"Arms PvP","Melee / PvP","Weapon damage > Strength > Stamina > Critical Strike"},{"Fury PvE","Melee / PvE","Weapon skill where relevant > Hit > Strength > Critical Strike"},{"Protection","Tank","Stamina > Defense > Armor > Strength > Hit"},{"Arms PvE Phase 1","Melee / PvE","Hit / weapon skill > Strength > Critical Strike; use encounter-specific effects where relevant"}},
 PALADIN={{"Holy","Healer","Healing power > Intellect > Mana per 5 > Spirit > Stamina"},{"Retribution","Melee / PvP","Weapon damage > Hit to melee cap (about 8%, weapon-skill dependent) > Expertise > Strength > Critical Strike; PvP adds Stamina and control"},{"Protection","Tank","Stamina > Defense > Armor > Spell power / threat"}},
 HUNTER={{"Beast Mastery PvP","Ranged / PvP","Agility / Critical Strike for pressure; Stamina and pet durability for survival. The 8% hit figure is a PvE boss benchmark, not a PvP target."},{"Beast Mastery PvE","Ranged / PvE","Hit to 8% > Critical Strike > Haste > Agility > Intellect > Ranged Attack Power"},{"Marksmanship","Ranged","Ranged weapon DPS > Agility > Hit > Critical Strike > Attack Power"},{"Survival","Ranged / Weaving","Agility > Hit > Critical Strike > Attack Power"}},
 ROGUE={{"Combat","Melee / PvE","Weapon skill where relevant > Hit > Agility > Attack Power"},{"Subtlety PvP","Melee / PvP","Weapon damage > Agility > Stamina > Attack Power > Critical Strike"},{"Assassination","Melee","Agility > Attack Power > Hit > Critical Strike"}},
 PRIEST={{"Holy / Discipline","Healer","Healing Power > Intellect > Mana per 5 > Spirit > Spell Critical Strike > Stamina (Holy level-60 order remains provisional)"},{"Shadow PvP","Caster / PvP","Spell damage > Stamina > Shadow damage > Intellect"},{"Shadow PvE Phase 1","Caster / PvE","Spell Power / Shadow Damage > Hit (17% is aspirational) > Critical Strike > Intellect > Spirit / MP5"}},
 MAGE={{"Frost PvP","Caster / PvP","Spell damage > Stamina > Intellect > Spell Critical Strike"},{"Fire PvE","Caster / PvE","Spell hit > Fire spell damage > Spell Critical Strike > Intellect"},{"Arcane","Caster","Spell damage > Spell hit > Intellect > Spell Critical Strike"}},
 WARLOCK={{"Affliction","Caster","Spell Power / Shadow Damage > Critical Strike > Hit (up to 12% from gear with 5/5 Suppression) > Haste > Spell Piercing > Intellect > Spirit"},{"Demonology PvP","Caster / PvP","Stamina > Spell damage > Intellect > Shadow damage"},{"Destruction","Caster","Spell hit > Spell damage > Spell Critical Strike > Intellect"}},
 DRUID={{"Feral Tank","Tank","Armor > Stamina > Agility > Defense / avoidance > Strength"},{"Feral DPS","Melee","Agility > Strength > Attack Power > Critical Strike"},{"Restoration","Healer","Healing power > Mana per 5 > Intellect > Spirit"},{"Balance","Caster","Spell damage > Spell hit > Intellect > Spell Critical Strike"}},
 SHAMAN={{"Elemental","Caster","Haste / Cast Speed > Hit to 17% > Critical Strike > Spell Piercing > Spell Damage > Nature / Fire Damage > Intellect > Spirit"},{"Enhancement","Melee","Weapon damage > Agility > Strength > Hit > Critical Strike"},{"Restoration","Healer","Healing power > Mana per 5 > Intellect > Spirit"}}
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
local SlotMap={
 Head={1}, Neck={2}, Shoulders={3}, Back={15}, Chest={5}, Wrist={9}, Hands={10},
 Waist={6}, Legs={7}, Feet={8}, Ring={11,12}, Trinket={13,14},
 ["Main Hand"]={16}, ["Off Hand"]={17}, Shield={17}, ["Two-Hand"]={16},
 Ranged={18}, Relic={18}
}
local function itemName(slot)
 local link=GetInventoryItemLink and GetInventoryItemLink("player",slot)
 if not link then return "Empty" end
 return (GetItemInfo and GetItemInfo(link)) or link
end
local function addUpgradeCheck(add,profile)
 add("EQUIPPED VS RECOMMENDED — SLOT CHECK","GameFontNormal")
 add("This is a named-item comparison, not a stat simulation. Check item effects, set bonuses, hit caps and PvP needs before replacing anything.","GameFontHighlightSmall")
 local grouped={}
 for _,item in ipairs(profile.items or {}) do
  local slot=item.slot
  if slot and item.name and item.name~="No verified item yet" then
   grouped[slot]=grouped[slot] or {}
   grouped[slot][#grouped[slot]+1]=item
  end
 end
 local order={"Head","Neck","Shoulders","Back","Chest","Wrist","Hands","Waist","Legs","Feet","Ring","Trinket","Main Hand","Off Hand","Shield","Two-Hand","Ranged","Relic"}
 for _,slotName in ipairs(order) do
  local picks=grouped[slotName]
  local slots=SlotMap[slotName]
  if picks and slots then
   local targets={}
   for _,candidate in ipairs(picks) do
    if tostring(candidate.rank or ""):find("BiS",1,true) then targets[#targets+1]=candidate end
   end
   if #targets==0 then targets[1]=picks[1] end
   for i,invSlot in ipairs(slots) do
    local target=targets[math.min(i,#targets)]
    if target then
     local current=itemName(invSlot)
     local status=(current:lower()==target.name:lower()) and "Already equipped" or "Target"
     add(slotName.." — "..current.."  →  "..target.name.." ["..status.."]","GameFontHighlight")
    end
   end
  end
 end
end
local function refresh()
 if not content then return end
 for _,v in ipairs(content.rows or {}) do v:Hide(); v:SetParent(nil) end; content.rows={}; local y=-5
 local function add(t,f) local v=text(content,t,y,f); content.rows[#content.rows+1]=v; y=y-v:GetStringHeight()-8 end
 local p,total=G:Profile(); local _,class=UnitClass("player")
 add((UnitName("player") or "Character").." • "..(class or "Unknown").." • Level "..UnitLevel("player"),"GameFontNormal")
 if p then add("PROFILE "..DB.profileIndex.."/"..total.." • "..p[1].." • "..p[2],"GameFontNormal"); add("STAT PRIORITY","GameFontNormal"); add(p[3]) end
 if Data.classGuideSources and Data.classGuideSources[class] then
  add("WOWHEAD FOREVER CLASS GUIDE","GameFontNormal")
  add(Data.classGuideSources[class])
 end
 if Data.dataStatus then add(Data.dataStatus,"GameFontHighlightSmall") end
 local profileKey=class.."|"..(p and p[1] or "")
 local gearProfile=Data.gearProfiles and Data.gearProfiles[profileKey]
 if gearProfile then
  add(gearProfile.title or "ITEM-BY-ITEM GEAR REFERENCE","GameFontNormal")
  add("Source updated: "..tostring(gearProfile.updated or "not dated").." • "..tostring(gearProfile.source or "source not recorded"),"GameFontHighlightSmall")
  if gearProfile.note then add(gearProfile.note) end
  if gearProfile.partial then add("COVERAGE: PARTIAL — see the linked source for unlisted slots and latest updates.","GameFontHighlightSmall") end
  if gearProfile.summary then add(gearProfile.summary,"GameFontHighlight") end
  add("SLOT-BY-SLOT RECOMMENDATIONS","GameFontNormal")
  local listedItems=0
  for _,item in ipairs(gearProfile.items or {}) do
   listedItems=listedItems+1
   add(item.slot.." — "..item.name.." ["..item.rank.."]","GameFontHighlight")
   add("Source: "..item.source,"GameFontHighlightSmall")
  end
  if listedItems==0 then add("No verified slot-by-slot item list is published in this profile yet.","GameFontHighlightSmall") end
  if gearProfile.extras and #gearProfile.extras>0 then
   add("SITUATIONAL TRINKETS & UTILITY","GameFontNormal")
   for _,item in ipairs(gearProfile.extras) do
    add(item.category..": "..item.name,"GameFontHighlight")
    add("Source: "..item.source,"GameFontHighlightSmall")
   end
  end
  addUpgradeCheck(add,gearProfile)
  if gearProfile.enchants and #gearProfile.enchants>0 then
   add("RECOMMENDED ENCHANTS","GameFontNormal")
   for _,v in ipairs(gearProfile.enchants) do add(v.slot..": "..v.name) end
  end
  if class=="HUNTER" and Data.hunterBM then
   add("PET SCALING IN FOREVER","GameFontNormal")
   for _,v in ipairs(Data.hunterBM.petScaling or {}) do add(v) end
  end
 elseif class=="HUNTER" and p and p[1]=="Beast Mastery PvE" and Data.hunterBM then
  add("BEAST MASTERY HUNTER — PHASE 1 PRE-RAID PVE","GameFontNormal")
  add("Wowhead updated "..Data.hunterBM.updated..". "..Data.hunterBM.note)
  add(Data.hunterBM.pvpNote or "PvP priorities differ from PvE stat weights.")
  add("PET SCALING IN FOREVER","GameFontNormal")
  for _,v in ipairs(Data.hunterBM.petScaling or {}) do add(v) end
  add("ITEM REFERENCE","GameFontNormal")
  for _,item in ipairs(Data.hunterBM.items or {}) do add(item.slot.." — "..item.name.." ["..item.rank.."]","GameFontHighlight"); add("Source: "..item.source,"GameFontHighlightSmall") end
  add("RANGED WEAPONS","GameFontNormal")
  for _,item in ipairs(Data.hunterBM.ranged or {}) do add(item.rank..": "..item.name.." — "..item.source) end
  addUpgradeCheck(add,Data.hunterBM)
  add("PVE ENCHANT REFERENCE","GameFontNormal")
  for _,v in ipairs(Data.hunterBM.enchants or {}) do add(v.slot..": "..v.name) end
 elseif p then
  add("No verified item-by-item list is available for this profile yet. The stat priority above is a starting point, not a BiS claim.")
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
