extends Node

@export var body: StaticBody3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bomb"):
		_break_wall()
	
func _break_wall():
	body.queue_free()
