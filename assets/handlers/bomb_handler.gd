class_name BombHandler
extends Node

@export var bomb_prefab: PackedScene
var explosion_range: int = 1
var max_bomb_instances: int = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (
		Input.is_action_just_pressed("drop_bomb") 
		and get_tree().get_nodes_in_group("bomb").size() < max_bomb_instances
	):
		var bomb: Bomb = bomb_prefab.instantiate()
		bomb.explosion_range = explosion_range

func add_range():
	explosion_range += 1
	
func add_max_bomb():
	max_bomb_instances += 1
