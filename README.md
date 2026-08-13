# godot-addons-example-project
A Godot minimal project to test our addons.

## Local addon testing

This project starts without addons installed. Keep `addons/.gitkeep` tracked so
Godot opens as a clean consumer project, then install addon builds explicitly for
each test pass.

For Build Me Godot, the installed shape must be:

```text
addons/build_me_godot/plugin.cfg
```

Use a normal copied/exported addon directory for release-style testing. For
live local development, a symlink is acceptable if it points exactly at the
addon package directory:

```bash
mkdir -p addons
ln -s /home/buddha/verdant/build-me-godot/addons/build_me_godot addons/build_me_godot
```

Do not copy or link the addon repository root, the top-level `build_me_godot/`
data folder, or a nested `addons/` directory.

## Run
1. Open this folder in Godot 4.x.
2. Press **Run Project** to launch `res://scenes/main.tscn`.

The default scene is a classic 3D smoke test: a rotating cube on a floor with a
camera, world environment, and directional light. It is intentionally simple so
addon behavior can be checked in a recognizable Godot project without pulling in
external art assets.
