extends MeshInstance3D

@export var rotation_speed := 0.7


func _process(delta: float) -> void:
	rotate_y(rotation_speed * delta)
