extends Node3D
class_name Flame

## Segment de flamme instancié case par case par bomb.gd.
## Détruit tout corps entrant en contact qui possède une méthode
## "take_damage" ou "on_flame_hit" (joueur, bloc destructible, etc).

@export var lifetime: float = 0.4
@export var damage: int = 1

@onready var area: Area3D = $Area3D


func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	await get_tree().create_timer(lifetime).timeout
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	if body.has_method("on_flame_hit"):
		body.on_flame_hit()
