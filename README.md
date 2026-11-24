# Taverners Gear Guide

Class-aware gearing reference for WoW Forever.

## Features
- Class/spec profile selector with PvP, PvE, tank, healer and melee/ranged starting priorities.
- Reads currently equipped gear.
- Item-by-item references now cover BM Hunter PvE/PvP, Marksmanship and Survival Hunter, Arms/Fury/Protection Warrior, Retribution Paladin, Combat/Assassination/Subtlety Rogue, Shadow and Holy/Disclipline Priest, Arcane/Fire/Frost Mage, Balance/Feral DPS/Feral Tank/Restoration Druid, Elemental/Enhancement/Restoration Shaman, and Affliction/Demonology/Destruction Warlock.
- Each set carries a source URL, last-reviewed date, slot, item rank and acquisition source; partial, speculative and evolving guides are explicitly labelled.
- Equipped-versus-recommended slot check compares the names in your current gear against the profile's recommended targets. It is a checklist, not a stat simulator or automatic upgrade score.
- Displays Wowhead's BM PvE stat order, pet inheritance details and recommended PvE enchants.
- Separates PvP guidance from the PvE 8% raid-boss hit benchmark; does not pretend that the PvE BiS list is a PvP set.
- Registers with TavernersCore for the Guild Hall dashboard.

Install TavernersCore, then place this folder in `Interface/AddOns/TavernersGearGuide`. Use `/tgear` or `/tgg`.

## Item-by-item set sources
- [Retribution Paladin](https://www.wowhead.com/forever/guide/classes/paladin/retribution/bis-gear)
- [Fury Warrior](https://www.wowhead.com/forever/guide/classes/warrior/fury/bis-gear)
- [Protection Warrior](https://www.wowhead.com/forever/guide/classes/warrior/protection/bis-gear)
- [Marksmanship Hunter](https://www.wowhead.com/forever/guide/classes/hunter/marksmanship/bis-gear)
- [Survival Hunter](https://www.wowhead.com/forever/guide/classes/hunter/survival/bis-gear)
- [Subtlety Rogue](https://www.wowhead.com/forever/guide/classes/rogue/subtlety/bis-gear)
- [Assassination Rogue](https://www.wowhead.com/forever/guide/classes/rogue/assassination/bis-gear)
- [Fire Mage](https://www.wowhead.com/forever/guide/classes/mage/fire/bis-gear)
- [Frost Mage](https://www.wowhead.com/forever/guide/classes/mage/frost/bis-gear)
- [Balance Druid](https://www.wowhead.com/forever/guide/classes/druid/balance/bis-gear)
- [Feral Bear Tank Druid](https://www.wowhead.com/forever/guide/classes/druid/feral/bis-gear-tank)
- [Restoration Druid](https://www.wowhead.com/forever/guide/classes/druid/restoration/bis-gear)
- [Enhancement Shaman](https://www.wowhead.com/forever/guide/classes/shaman/enhancement/bis-gear)
- [Restoration Shaman](https://www.wowhead.com/forever/guide/classes/shaman/restoration/bis-gear)
- [Discipline Priest](https://www.wowhead.com/forever/guide/classes/priest/discipline/bis-gear)
- [Demonology Warlock](https://www.wowhead.com/forever/guide/classes/warlock/demonology/bis-gear)
- [Destruction Warlock](https://www.wowhead.com/forever/guide/classes/warlock/destruction/bis-gear)
- [BM Hunter pre-raid PvP gear (Skill Capped)](https://www.skill-capped.com/wowarticles/forever/guides/beast-mastery-hunter-pvp-guide/gearing/)
- [Arms Warrior Phase 1 BiS](https://www.wowhead.com/forever/guide/classes/warrior/arms/bis-gear)
- [Combat Rogue Phase 1 BiS](https://www.wowhead.com/forever/guide/classes/rogue/combat/bis-gear)
- [Shadow Priest Phase 1 BiS](https://www.wowhead.com/forever/guide/classes/priest/shadow/bis-gear)
- [Arcane Mage Phase 1 BiS](https://www.wowhead.com/forever/guide/classes/mage/arcane/bis-gear)
- [Feral Druid Phase 1 BiS](https://www.wowhead.com/forever/guide/classes/druid/feral/bis-gear-dps)
- [Elemental Shaman Phase 1 BiS](https://www.wowhead.com/forever/guide/classes/shaman/elemental/bis-gear)
- [Affliction Warlock Phase 1 BiS](https://www.wowhead.com/forever/guide/classes/warlock/affliction/bis-gear)

## General class planner and Hunter sources
- [Wowhead Forever — Beast Mastery Hunter Phase 1 Pre-Raid BiS](https://www.wowhead.com/forever/guide/classes/hunter/beast-mastery/bis-gear)
- [Wowhead Forever — BM Hunter stat priority](https://www.wowhead.com/forever/guide/classes/hunter/beast-mastery/stat-priority-pve-dps)
- [Wowhead Forever — BM Hunter enchants and consumables](https://www.wowhead.com/forever/guide/classes/hunter/beast-mastery/enchants-consumables-pve-dps)
- [Wowhead Forever — BM Hunter overview and pet changes](https://www.wowhead.com/forever/guide/classes/hunter/beast-mastery/overview-pve-dps)
- [Wowhead Forever — Elemental Shaman stat priority](https://www.wowhead.com/forever/guide/classes/shaman/elemental/stat-priority-pve-dps)
- [Wowhead Forever — Affliction Warlock stat priority](https://www.wowhead.com/forever/guide/classes/warlock/affliction/stat-priority-pve-dps)
- [Wowhead Forever — Holy Priest stat priority](https://www.wowhead.com/forever/guide/classes/priest/holy/stat-priority-pve-healer)
- [Wowhead Forever — Retribution Paladin stat guide](https://www.wowhead.com/forever/guide/classes/paladin/retribution/stat-priority-pve-dps)
- [Wowhead Forever Gear Planner](https://www.wowhead.com/forever/gear-planner)

The BM list is a PvE pre-raid reference, not a dedicated PvP set. Wowhead notes the guide is evolving and distinguishes AoE from single-target ranged weapons. This is broader coverage, not a claim that every specialization has a complete verified BiS list. Many new profiles are intentionally partial because their Forever guides are still evolving, speculative, or missing slots. Assassination Rogue and Holy/Discipline Priest currently have no complete slot-by-slot list in this addon. Arms Warrior PvP, Holy/Protection Paladin and Shadow Priest PvP are explicitly guidance-only until a suitable Forever-specific set is verified. Open the linked source before committing to a long farm. The BM Hunter PvP set is labelled predicted/work-in-progress and not yet tested in game by its source. It now includes situational damage, survival, control and mobility trinket options. Do not treat generic priorities as a substitute for a spec-specific, current gear set.

Interface target 16001. Live-client API testing is still required.
