extends Node3D
class_name Bomb


@export_group("Timing")
@export var fuse_time: float = 3.0          # Délai avant explosion (secondes)

@export_group("Explosion")
@export var explosion_range: int = 1     # Portée =  nb cases dans chaque direction
@export var cell_size: float = 1.0          # Taille d'une case de la grille (unités Godot)
@export var explosion_scene: PackedScene    # Scène de flamme

@export_group("Physique")
@export_flags_3d_physics var wall_collision_mask: int = 1
# Layer physique sur laquelle se trouvent murs / blocs qui doivent
# stopper la propagation de la flamme (aide IA)

@onready var fuse_timer: Timer = $FuseTimer
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var body: StaticBody3D = $StaticBody3D

var _has_exploded := false

signal exploded(bomb: Bomb)


func _ready() -> void:
	fuse_timer.wait_time = fuse_time
	fuse_timer.one_shot = true
	fuse_timer.timeout.connect(_on_fuse_timeout)
	fuse_timer.start()


func _on_fuse_timeout() -> void:
	explode()


## Peut aussi être appelé manuellemen (réaction en chaîne avec une autre bombe qui explose à côté)
func explode() -> void:
	if _has_exploded:
		return
	_has_exploded = true

	# desactive visuel et collision physique de bombe
	mesh.visible = false
	body.set_collision_layer_value(1, false)
	body.set_collision_mask_value(1, false)

	# flamme centrale
	_spawn_flame(global_position)

	var directions := {
		"front": -global_transform.basis.z,
		"back": global_transform.basis.z,
		"left": -global_transform.basis.x,
		"right": global_transform.basis.x,
	}

	for dir_name in directions.keys():
		var dir: Vector3 = directions[dir_name].normalized()
		var length := _get_flame_length(dir)
		_spawn_flame_line(dir, length)

	exploded.emit(self)

	# délai pour laisser les flammes s'affiche bien puis libérer la bombe
	await get_tree().create_timer(0.05).timeout
	queue_free()


func _get_flame_length(dir: Vector3) -> int:
	var space_state := get_world_3d().direct_space_state

	var box := BoxShape3D.new()
	box.size = Vector3.ONE * cell_size * 0.8 

	var query := PhysicsShapeQueryParameters3D.new()
	query.shape = box
	query.collision_mask = wall_collision_mask
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.exclude = [body.get_rid()]

	for i in range(1, explosion_range + 1):
		var cell_pos := global_position + dir * cell_size * i
		query.transform = Transform3D(Basis.IDENTITY, cell_pos)
		if not space_state.intersect_shape(query, 1).is_empty():
			return i - 1   # la case i est bloquée, on s'arrête avant

	return explosion_range


func _spawn_flame_line(dir: Vector3, length: int) -> void:
	for i in range(1, length + 1):
		_spawn_flame(global_position + dir * cell_size * i)


func _spawn_flame(pos: Vector3) -> void:
	if explosion_scene == null:
		push_warning("Bomb: aucune 'explosion_scene' assignée, impossible d'afficher la flamme.")
		return
	var flame := explosion_scene.instantiate()
	get_tree().current_scene.add_child(flame)
	flame.global_position = pos
