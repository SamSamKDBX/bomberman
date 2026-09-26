extends Node

@export var body: Node3D
@export var hp: int = 1

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bomb"):
		_take_damage()
	
func _take_damage():
	hp -= 1
	if hp == 0:
		_death()

func _death():
	body.queue_free()
