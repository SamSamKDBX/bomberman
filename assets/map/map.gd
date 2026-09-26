extends StaticBody3D

@export var prefab: StaticBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(-9.5, 9.5, 1):
		add_child(prefab)
