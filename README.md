# Jones

Open world sandbox RPG: WoW-style tab-target combat, RuneScape-style skilling and
progression, and a dark, stylized world inspired by Diablo 2.

Built with **Godot 4.5** (GL Compatibility renderer) so it runs in any browser,
including phones and tablets.

- Design doc: [docs/game-design-doc.md](docs/game-design-doc.md)
- Every push to `main` builds a web version (see the **Build** workflow).

## Controls (M0)

| Action | Keyboard / mouse | Touch |
|---|---|---|
| Move | WASD or arrows | Joystick, bottom left |
| Jump | Space | |
| Look | Hold right mouse and drag | Swipe |
| Zoom | Scroll wheel | Pinch |

## Working on it locally (optional)

Open `project.godot` in Godot 4.5. Run the headless smoke test with:

```
godot --headless -s tests/smoke_test.gd
```

## Layout

```
scenes/   .tscn scenes (text format)
scripts/  GDScript
tests/    headless tests run in CI
docs/     design docs
```
