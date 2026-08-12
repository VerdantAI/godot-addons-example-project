# godot-addons-example-project
A Godot minimal project to test our addons.

## Local addon development

For Build Me Godot development, install the addon as a symlink so changes in the
addon repository are active here immediately:

```bash
mkdir -p addons
ln -s /home/buddha/verdant/build-me-godot/addons/build_me_godot addons/build_me_godot
```

The symlink is for local development only. For release or Store-package testing,
replace it with a normal copied/exported addon install.

## Run
1. Open this folder in Godot 4.x.
2. Press **Run Project** to launch `res://scenes/main.tscn`.

The default scene is a classic 3D smoke test: a rotating cube on a floor with a
camera, world environment, and directional light. It is intentionally simple so
addon behavior can be checked in a recognizable Godot project without pulling in
external art assets.
