# Field Engineer Image-to-3D Backend Comparison

Date checked: 2026-08-14

Input image:

- `build_me_godot/characters/field_engineer/conformance/v1/provider_inputs/front_trellis_rgba.png`

## TRELLIS

- Upstream checkout: `/home/buddha/src/TRELLIS`
- Commit: `442aa1e1afb9014e80681d3bf604e8d728a86ee7`
- Model path: `/home/buddha/models/TRELLIS-image-large`
- Output: `build_me_godot/characters/field_engineer/conformance/v1/proxy_meshes/trellis_front.glb`
- Metadata: `trellis_front_metadata.json`
- Blender stats: `trellis_front_blender_stats.json`
- Preview: `/tmp/trellis_front_compare_preview.png`
- Runtime: 23.54 seconds
- Vertices: 5,430
- Polygons: 6,898
- Materials: 1
- GLB size: 1.5 MiB

Observed result: best ready-to-inspect textured proxy. The helmet, vest, gloves, belt pouches, pants, and boots are recognizable. Geometry is lightweight enough to serve as a proxy/reference mesh, but topology is not production animation topology.

## Hunyuan3D 2.1 Shape

- Upstream checkout: `/home/buddha/src/Hunyuan3D-2.1`
- Commit: `82920d643c0dc2f7bfd7255f45f62d386edfe60c`
- Model: `tencent/Hunyuan3D-2.1`
- Output: `build_me_godot/characters/field_engineer/conformance/v1/proxy_meshes/hunyuan_front.glb`
- Metadata: `hunyuan_front_metadata.json`
- Blender stats: `hunyuan_front_blender_stats.json`
- Preview: `/tmp/hunyuan_front_preview.png`
- Runtime: 73.13 seconds
- Peak allocated VRAM: 7,841.8 MiB
- Vertices: 167,404
- Polygons: 334,828
- Materials: 0
- GLB size: 5.8 MiB

Observed result: strongest shape reconstruction so far. The helmet, sleeves, collar, belt pouches, pants, boots, and broad humanoid silhouette read clearly. This shape pass is untextured and too dense for direct Godot use without cleanup/decimation/retopo.

## Hunyuan3D 2.1 Texture Blocker

The shape pipeline ran successfully in the isolated Hunyuan venv with Torch `2.8.0+cu129`.

The PBR texture path did not get past dependency loading:

- `hy3dpaint` imports Python `bpy`; the isolated Hunyuan venv does not include it.
- pymeshlab reports missing `libOpenGL.so.0` inside the container.
- Upstream documents approximately 21 GB VRAM for texture generation, which exceeds the RTX 5070 Ti class card available here.

Do not install the texture stack into the existing ComfyUI environment. If this branch is pursued, put Hunyuan paint in the local toolchain container with the missing runtime libraries and `bpy`, then test at `max_num_view=6` and `resolution=512` first.

## Current Recommendation

Use TRELLIS as the default local textured proxy backend for the current field engineer workflow.

Keep Hunyuan3D 2.1 as an optional shape backend when sculpt detail matters more than immediate texture readiness. Its output should flow through Blender cleanup before any rigging attempt.

Do not route either output directly into production rigging as final topology. Treat both generated meshes as immutable reconstruction references, then use Blender cleanup and a separate rigging stage.
