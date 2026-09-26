# Jones

Godot 4.5 game, GDScript, GL Compatibility renderer, exported to the web. The design
doc is docs/game-design-doc.md; milestones there (M0, M1, ...) drive the work.

## Working in a cloud session

Godot isn't preinstalled. Download the editor binary (and, only if you need a web
export, the export templates) the same way `.github/workflows/build.yml` does, into
the scratchpad, never into the repo.

- Import once: `godot --headless --import`
- Smoke test: `godot --headless -s tests/smoke_test.gd` (must pass before pushing)

## Conventions

- Scenes stay in text `.tscn` format; build procedural or repetitive content in code.
- Input actions are registered in `scripts/input_setup.gd`, not in project.godot.
- Touch input must work for anything the keyboard can do (the game is played on phones).
- Commit the `.gd.uid` files Godot generates next to scripts.
