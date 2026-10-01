extends Node

@export var root: Node3D
@export var dangerousGroups: Array[String]
@export var hp: int = 1
signal death

func _process(_delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.is_empty():
		_winning()

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
	if root.is_in_group("player"):
		_loosing()
	death.emit()
	root.queue_free()
	
func _loosing():
	get_tree().change_scene_to_file("res://scenes/loosing_menu/loosing_menu.tscn")

func _winning():
	get_tree().change_scene_to_file("res://scenes/winning_menu/winning_menu.tscn")
