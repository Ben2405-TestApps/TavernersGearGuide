# Taverners Gear Guide

Class-aware gearing reference for WoW Forever.

## Features
- Class/spec profile selector with PvP, PvE, tank, healer and melee/ranged starting priorities.
- Reads currently equipped gear.
- Item-by-item Phase 1 sets for BM Hunter PvE and PvP, Arms Warrior, Combat Rogue, Shadow Priest, Arcane Mage, Feral Druid, Elemental Shaman and Affliction Warlock.
- Each set carries a source URL, last-reviewed date, slot, item rank and acquisition source; partial or evolving sets are labelled.
- Displays Wowhead's BM PvE stat order, pet inheritance details and recommended PvE enchants.
- Separates PvP guidance from the PvE 8% raid-boss hit benchmark; does not pretend that the PvE BiS list is a PvP set.
- Registers with TavernersCore for the Guild Hall dashboard.

Install TavernersCore, then place this folder in `Interface/AddOns/TavernersGearGuide`. Use `/tgear` or `/tgg`.

## Item-by-item set sources
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

The BM list is a PvE pre-raid reference, not a dedicated PvP set. Wowhead notes the guide is evolving and distinguishes AoE from single-target ranged weapons. The current database is a first pass, not complete coverage of every spec. Elemental Shaman and Affliction Warlock are explicitly partial; the remaining specs still need item-by-item research. The BM Hunter PvP set is labelled predicted/work-in-progress and not yet tested in game by its source. It now includes situational damage, survival, control and mobility trinket options. Do not treat generic priorities as a substitute for a spec-specific, current gear set.

Interface target 16001. Live-client API testing is still required.
