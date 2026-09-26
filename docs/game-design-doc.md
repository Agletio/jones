# Jones: Game Design Doc (v0.1)

Working title: **Jones**. Open world sandbox RPG.
One-line pitch: WoW-style tab-target combat, RuneScape-style skilling and freeform progression, in a dark, gritty, stylized world inspired by Diablo 2.

---

## 1. Tech and workflow

| Choice | Decision | Why |
|---|---|---|
| Engine | **Godot 4 (GDScript), 3D** | Free, open source, and every scene, resource and script is plain text, so Claude can build it entirely from a cloud session with no local editor. |
| Renderer | Compatibility (OpenGL/WebGL2) | Runs in a browser on phone, tablet or PC. |
| Builds | GitHub Actions exports a **web build** on every merge, published to GitHub Pages | Austin can play the latest version from any device by opening a link. |
| Repo | One GitHub repo under Agletio | Each change lands as a PR you can review from the chat. |
| Art | Low-poly stylized models, hand-painted-style textures, heavy lighting/fog doing the mood | Achievable without a big art team; matches the "stylized, not realistic" goal. Placeholder primitives first, real assets later (free packs like Quaternius/Kenney, then custom). |

You can still open the project in the Godot editor on a desktop anytime; nothing locks you out of that.

## 2. Pillars

1. **Freedom over direction.** No class lock. You become what you train. Quests exist but are never mandatory.
2. **Combat that rewards attention.** Tab-target, cooldowns, positioning, interrupts. Not button-mash.
3. **Every skill feeds another.** Gathering feeds crafting feeds combat feeds gathering. The economy is the progression.
4. **A world that feels hostile.** Dark, decaying, dangerous. Safety is earned, light is precious.

## 3. Core loops

**Moment to moment (seconds):** target an enemy, use abilities, manage resources and cooldowns, or gather/craft with short timed actions.

**Session (minutes to an hour):** pick a goal (a level, an item, a zone), travel, gather or fight, return to a town to bank, craft, sell, repeat.

**Long term (weeks):** max skills, unlock gear tiers, open new regions, take on elite/boss content, build a home or outpost (sandbox layer).

```
 Gather ──► Craft ──► Gear up ──► Fight ──► Loot/materials ──┐
   ▲                                                        │
   └──────────────── Sell / trade / bank ◄──────────────────┘
```

## 4. Combat (WoW-style tab target)

- **Targeting:** Tab cycles nearest hostiles in front of the camera; click to target; target frame shows health, cast bar, debuffs.
- **Abilities:** hotbar of 1–10 (plus mobile touch buttons). Global cooldown ~1.5s, individual cooldowns, cast times, channels, instants.
- **Resources:** Health plus one combat resource per style (Rage for melee, Focus for ranged, Mana for magic). Weapon/gear equipped decides which abilities you have, not a class.
- **Combat styles are skills:** Melee, Ranged, Magic, Defense each level independently (RuneScape feel). Leveling a style unlocks its abilities.
- **Enemy AI:** aggro radius, threat table, leashing, telegraphed special attacks you can step out of or interrupt.
- **Death:** respawn at last shrine; you drop a portion of carried (unbanked) items as a gravestone you can recover. Gritty but not brutal.

## 5. Skills (RuneScape-style)

Each skill levels 1–99 via XP from doing it. Starting set, grouped:

| Gathering | Crafting | Combat | Utility |
|---|---|---|---|
| Mining | Smithing | Melee | Agility |
| Woodcutting | Fletching | Ranged | Thieving |
| Fishing | Cooking | Magic | Slayer (hunt tasks) |
| Herbalism | Alchemy (potions) | Defense | Construction (sandbox building) |
| Hunting | Leatherworking / Tailoring | Vitality (HP) | |
|  | Runecraft (magic ammo) | | |

Rules: resource nodes and recipes have level gates; higher tiers of ore/wood/fish live deeper in dangerous zones, tying skilling to combat risk.

## 6. World

- **Setting:** a land slowly consumed by a spreading corruption after an old evil woke under the mountains. Fallen kingdoms, cursed monasteries, plague villages, ash deserts, a hellish underworld at the end. (Diablo 2 tone: dread, gothic, desperate survivors.)
- **Structure:** one seamless-feeling open world split into regions streamed as chunks. Danger rises the further you go from the starting town.
  1. **Greywater** (start): marsh town with a failing palisade; low-level forest, bogs.
  2. **Ashen Moors:** burned farmland, bandits, the undead.
  3. **The Sunken Abbey:** dungeon region, cultists, first major boss.
  4. **Blighted Wastes:** desert, sand-buried ruins, demons.
  5. **The Deep:** underworld endgame.
- **Towns** are safe hubs with bank, shops, crafting stations, quest givers.
- **Dungeons** are instanced-feeling interiors with bosses and better loot.

## 7. Items and loot

- Diablo-style rarity: Common (white), Magic (blue), Rare (yellow), Unique (gold), Set (green).
- Randomized affixes on drops; crafted gear is reliable but capped; best gear mixes both.
- Gear slots: head, chest, legs, hands, feet, main hand, off hand, neck, 2 rings, cloak.
- Inventory grid plus bank. Player trading later.

## 8. Sandbox layer (later)

- Claim a plot outside town, build with Construction (walls, crafting stations, storage, lights that push back corruption).
- Corruption events can threaten player outposts.

## 9. Art and audio direction

- **Look:** stylized low-poly, chunky silhouettes, painted textures, desaturated palette with rare saturated accents (blood red, torch orange, spectral teal).
- **Lighting:** it carries the mood. Dark nights, fog, torchlight falloff, heavy vignette.
- **Camera:** third-person over-the-shoulder, zoomable up to a high angle that recalls Diablo's view.
- **UI:** gothic stone/iron frames, parchment tooltips, legible fonts.
- **Audio:** sparse ambient drones, distant bells, acoustic guitar/strings in towns (a nod to Tristram).

## 10. Scope and milestones

Single-player first, built so multiplayer can be added later (server-authoritative-friendly data model), but no networking at start.

1. **M0 Skeleton:** repo, Godot project, web build auto-published, a test level with a player you can move (keyboard + touch).
2. **M1 Combat slice:** tab targeting, hotbar with 3 abilities, one enemy type with AI, health/death/respawn.
3. **M2 Skilling slice:** Woodcutting + Mining + Smithing, inventory, bank, XP and levels UI.
4. **M3 Greywater:** first town and surrounding zone, NPCs, shops, first quest, loot rarities.
5. **M4 Art pass:** replace primitives with stylized assets, lighting and fog mood.
6. Then: more regions, skills, dungeons, sandbox building, save system to cloud.

## Open questions

- Solo experience only, or is multiplayer an eventual must-have?
- Controller support priority vs keyboard/touch.
