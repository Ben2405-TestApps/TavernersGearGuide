# Taverners Gear Guide

Class-aware gearing reference for WoW Forever.

## Features
- Class/spec profile selector with PvP, PvE, tank, healer and melee/ranged starting priorities.
- Reads currently equipped gear.
- Includes a sourced Beast Mastery Hunter Phase 1 pre-raid item reference, including item slots, acquisition sources, alternatives and ranged weapon distinctions.
- Displays Wowhead's BM PvE stat order, pet inheritance details and recommended PvE enchants.
- Separates PvP guidance from the PvE 8% raid-boss hit benchmark; does not pretend that the PvE BiS list is a PvP set.
- Registers with TavernersCore for the Guild Hall dashboard.

Install TavernersCore, then place this folder in `Interface/AddOns/TavernersGearGuide`. Use `/tgear` or `/tgg`.

## Data source
- [Wowhead Forever — Beast Mastery Hunter Phase 1 Pre-Raid BiS](https://www.wowhead.com/forever/guide/classes/hunter/beast-mastery/bis-gear)
- [Wowhead Forever — BM Hunter stat priority](https://www.wowhead.com/forever/guide/classes/hunter/beast-mastery/stat-priority-pve-dps)
- [Wowhead Forever — BM Hunter enchants and consumables](https://www.wowhead.com/forever/guide/classes/hunter/beast-mastery/enchants-consumables-pve-dps)
- [Wowhead Forever — BM Hunter overview and pet changes](https://www.wowhead.com/forever/guide/classes/hunter/beast-mastery/overview-pve-dps)
- [Wowhead Forever — Elemental Shaman stat priority](https://www.wowhead.com/forever/guide/classes/shaman/elemental/stat-priority-pve-dps)
- [Wowhead Forever — Affliction Warlock stat priority](https://www.wowhead.com/forever/guide/classes/warlock/affliction/stat-priority-pve-dps)
- [Wowhead Forever — Holy Priest stat priority](https://www.wowhead.com/forever/guide/classes/priest/holy/stat-priority-pve-healer)
- [Wowhead Forever — Retribution Paladin stat guide](https://www.wowhead.com/forever/guide/classes/paladin/retribution/stat-priority-pve-dps)
- [Wowhead Forever Gear Planner](https://www.wowhead.com/forever/gear-planner)

The BM list is a PvE pre-raid reference, not a dedicated PvP set. Wowhead notes the guide is evolving and distinguishes AoE from single-target ranged weapons. Other class profiles provide class/spec starting priorities and planner links. Elemental Shaman, Affliction Warlock, Holy Priest and Retribution Paladin now include direct Wowhead class-guide references; their item-by-item BiS lists are not yet complete. Do not treat generic priorities as a substitute for a spec-specific, current gear set.

Interface target 16001. Live-client API testing is still required.
