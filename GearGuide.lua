local ADDON,ns=...
local Core=_G.TavernersCore
if not Core then return end
local DB=Core.Database:Register("TavernersGearGuideDB",{version=1,profileIndex=1},1)
local Profiles={
 WARRIOR={{"Arms PvP","Melee / PvP","Weapon damage > Strength > Stamina > Critical Strike > Agility"},{"Fury PvE","Melee / PvE","Weapon skill where relevant > Hit > Strength > Critical Strike"},{"Protection","Tank","Stamina > Defense > Armor > Strength > Hit / threat"}},
 PALADIN={{"Holy","Healer","Healing power > Intellect > Mana per 5 > Spirit > Stamina"},{"Retribution","Melee / PvP","Weapon damage > Strength > Stamina > Critical Strike"},{"Protection","Tank","Stamina > Defense > Armor > Spell power / threat > Intellect"}},
 HUNTER={{"Beast Mastery PvP","Ranged / PvP","Ranged weapon damage > Agility > Stamina > Critical Strike > Intellect"},{"Marksmanship PvE","Ranged / PvE","Ranged weapon DPS > Agility > Hit > Critical Strike > Attack Power"},{"Survival","Ranged / Utility","Agility > Stamina > Attack Power > Critical Strike"}},
 ROGUE={{"Combat","Melee / PvE","Weapon skill where relevant > Hit > Agility > Strength > Attack Power"},{"Subtlety PvP","Melee / PvP","Weapon damage > Agility > Stamina > Attack Power > Critical Strike"},{"Assassination","Melee","Agility > Attack Power > Hit > Critical Strike"}},
 PRIEST={{"Holy / Discipline","Healer","Healing power > Intellect > Mana per 5 > Spirit > Stamina"},{"Shadow PvP","Caster / PvP","Spell damage > Stamina > Shadow damage > Intellect"}},
 MAGE={{"Frost PvP","Caster / PvP","Spell damage > Stamina > Intellect > Spell Critical Strike"},{"Fire PvE","Caster / PvE","Spell hit > Fire spell damage > Spell Critical Strike > Intellect"},{"Arcane","Caster","Spell damage > Spell hit > Intellect > Spell Critical Strike"}},
 WARLOCK={{"Affliction","Caster","Spell damage > Spell hit > Stamina > Intellect"},{"Demonology PvP","Caster / PvP","Stamina > Spell damage > Intellect > Shadow damage"},{"Destruction","Caster","Spell hit > Spell damage > Spell Critical Strike > Intellect"}},
 DRUID={{"Feral Tank","Tank","Armor > Stamina > Agility > Defense / avoidance > Strength"},{"Feral DPS","Melee","Agility > Strength > Attack Power > Critical Strike"},{"Restoration","Healer","Healing power > Mana per 5 > Intellect > Spirit"},{"Balance","Caster","Spell damage > Spell hit > Intellect > Spell Critical Strike"}}
}
local G={db=DB}
function G:Class() local _,c=UnitClass("player"); return c or "WARRIOR" end
function G:Profile() local list=Profiles[self:Class()] or {}; if #list==0 then return nil end; if DB.profileIndex>#list then DB.profileIndex=1 end; return list[DB.profileIndex],#list end
function G:Next() local list=Profiles[self:Class()] or {}; if #list>0 then DB.profileIndex=DB.profileIndex%#list+1 end; if self.UI then self.UI:Refresh() end end
function G:Equipped() local out={}; for slot=1,19 do local link=GetInventoryItemLink("player",slot); if link then out[#out+1]=GetItemInfo(link) or link end end; return out end
Core:RegisterModule("GearGuide",G)
local frame,content
local function text(parent,t,y,font) local fs=parent:CreateFontString(nil,"OVERLAY",font or "GameFontHighlight"); fs:SetPoint("TOPLEFT",8,y); fs:SetWidth(630); fs:SetJustifyH("LEFT"); fs:SetWordWrap(true); fs:SetText(t); return fs end
local function refresh()
 if not content then return end
 for _,v in ipairs(content.rows or {}) do v:Hide(); v:SetParent(nil) end; content.rows={}; local y=-5
 local function add(t,f) local v=text(content,t,y,f); content.rows[#content.rows+1]=v; y=y-v:GetStringHeight()-9 end
 local p,total=G:Profile(); local _,class=UnitClass("player")
 add((UnitName("player") or "Character").." • "..(class or "Unknown").." • Level "..UnitLevel("player"),"GameFontNormal")
 if p then add("BUILD "..DB.profileIndex.."/"..total.." • "..p[1].." • "..p[2],"GameFontNormal"); add("STAT PRIORITY","GameFontNormal"); add(p[3]); else add("No class profile available.") end
 add("EQUIPPED GEAR","GameFontNormal")
 local gear=G:Equipped(); for _,item in ipairs(gear) do add(item) end; if #gear==0 then add("No equipped items could be read.") end
 add("These are qualitative starting priorities, not universal numeric stat weights. Level, talents, gear, target level and PvP/PvE context all matter.")
 add("An item-by-item pre-raid and PvP database will be added as verified data packs; no unverified drops or best-in-slot claims are included.")
 content:SetHeight(math.max(1,-y+20))
end
local function build()
 if frame then return end
 frame=CreateFrame("Frame","TavernersGearGuideFrame",UIParent); frame:SetSize(700,500); frame:SetPoint("CENTER"); frame:SetFrameStrata("DIALOG"); frame:SetMovable(true); frame:EnableMouse(true); frame:RegisterForDrag("LeftButton"); frame:SetScript("OnDragStart",frame.StartMoving); frame:SetScript("OnDragStop",frame.StopMovingOrSizing)
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
SLASH_TAVERNERSGEARGUIDE1="/tgear"; SLASH_TAVERNERSGEARGUIDE2="/tgg"; SlashCmdList=SlashCmdList or {}; SlashCmdList.TAVERNERSGEARGUIDE=function() G.UI:Toggle() end
