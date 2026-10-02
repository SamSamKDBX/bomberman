extends Node

@export var body: StaticBody3D
@export var bonusPrefabs: Array[PackedScene]

func _on_break():
	# 1 chance sur 2 de faire apparaître un bonus
	var containBonus: int = randi() % 2
	if containBonus == 1:
		# Instancier un bonus au hasard
		var bonus = bonusPrefabs[randi() % bonusPrefabs.size()].instantiate()
		var tree = get_tree()
		if tree:
			tree.current_scene.add_child(bonus)
			bonus.global_position = body.global_position
