# Field Engineer Rigging and Animation Handoff

Date checked: 2026-08-14

## Outputs

- TRELLIS rig-test GLB: `build_me_godot/characters/field_engineer/conformance/v1/animated/trellis_front_quaternius_rig_test.glb`
- Hunyuan rig-test GLB: `build_me_godot/characters/field_engineer/conformance/v1/animated/hunyuan_front_quaternius_rig_test.glb`
- TRELLIS rig report: `trellis_front_quaternius_rig_report.json`
- Hunyuan rig report: `hunyuan_front_quaternius_rig_report.json`
- Re-import validation: `animated_glb_reimport_validation.json`

## Method

Both generated proxy meshes were imported into Blender and bound to the existing local Quaternius male humanoid armature from:

- `build_me_godot/blender/assets/library/quaternius_humanoid_bases_with_animations.blend`

The script:

- aligns the generated mesh to the Quaternius male donor mesh;
- transfers 65 humanoid vertex groups from `QTR_Male_SuperHero_Male`;
- binds the generated mesh to `QTR_Male_Rig`;
- applies a conservative procedural `Rig_Test` action;
- isolates that action for export so Blender imports it as the active `Animation` action;
- exports a Godot-compatible GLB.

The earlier `Walk_Loop` smoke export was intentionally replaced. Full walk-cycle
motion exposed donor-weight artifacts on generated clothing and accessory
geometry, including wing-like spikes in Godot's import preview. `Rig_Test` is a
small deformation sanity check, not a locomotion animation.

Script:

- `build_me_godot/blender/tools/rig_generated_proxy_with_quaternius.py`

## Validation

TRELLIS:

- vertices before export: 5,430
- polygons before export: 6,898
- materials: 1
- vertex groups: 65
- armature modifier: yes
- test deformation delta at frame 16: 0.091801
- re-imported armature bones: 65
- re-imported actions: 1
- re-imported active action: `Animation`
- re-imported deformation delta, frame 0 to 16: 0.091801

Hunyuan:

- vertices before export: 167,404
- polygons before export: 334,828
- materials: 0
- vertex groups: 65
- armature modifier: yes
- test deformation delta at frame 16: 0.095916
- re-imported armature bones: 65
- re-imported actions: 1
- re-imported active action: `Animation`
- re-imported deformation delta, frame 0 to 16: 0.095916

## Known Issues

This is a smoke-test rig, not production skinning. Weight transfer comes from a stylized humanoid donor and will need manual cleanup around shoulders, hips, fingers, tools, boots, and belt accessories before using stronger motions such as walk cycles.

The Blender glTF exporter reintroduces tiny unskinned `Icosphere` helper meshes when exporting this Quaternius armature. They are not part of the generated character skin and have zero vertex groups. They should be harmless for inspection, but a production exporter should strip or avoid those helper shapes.

Hunyuan remains untextured in this run. Its geometry is much denser than TRELLIS and should be decimated or retopologized before production Godot use.
