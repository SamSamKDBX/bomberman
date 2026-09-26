extends Node

@export var root: Node3D
@export var dangerousGroups: Array[String]
@export var hp: int = 1

func _on_area_3d_body_entered(body: Node3D) -> void:
	for dangerousGroup in dangerousGroups:
		if body.is_in_group(dangerousGroup):
			_take_damage()
			break
	
func _take_damage():
	hp -= 1
	if hp == 0:
		_death()

func _death():
	if get_tree().get_nodes_in_group("enemy").is_empty():
		_winning()
	root.queue_free()
	
func _winning():
	pass
