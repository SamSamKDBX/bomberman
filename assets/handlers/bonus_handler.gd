extends Node

@export var bomb_handler: BombHandler
@export var bonus_area: Area3D

func _ready() -> void:
	bonus_area.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node3D):
	if body.is_in_group("expend_explosion_bonus"):
		bomb_handler.add_range()
	elif body.is_in_group("more_bomb_bonus"):
		bomb_handler.add_max_bomb()
