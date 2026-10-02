extends Node

@export var body: CharacterBody3D
@export var speed: int = 4
@export var ray_north: CollisionShape3D


@export var bomb_prefab: PackedScene
var explosion_range: int = 1
var max_bomb_instances: int = 1
@export var bonus_area: Area3D



var rng = RandomNumberGenerator.new()
var nextStop: Vector3
var step: int = 1
var ray_length : int = 1
var bombs_capacity: int
var orientation = "x+"
var collideBottom: bool = false
var collideTop: bool = false
var collideWest: bool = false
var collideEast: bool = false
var bomb = preload("res://assets/bomb/bomb.tscn")
var bomb_instances: Array[Bomb]
var addingBomb: bool

func _ready() -> void:
	body.position = Vector3.ZERO
	nextStop = body.position
	collideEast = false
	bonus_area.body_entered.connect(_on_body_entered)
	
	
func _physics_process(delta: float) -> void:
	# Si on est arrivé à la prochaine étape

	print("player", body.position)
	if orientation[0] == "x":
		# FOR DEBUGING PURPOSE
		#
		#print("---------")
		#print("1")
		#print("centerDirected : ", centerDirected)
		#print("body.position : ", body.position)
		#print("nextStop : ", nextStop)
		#print("orientation : ", orientation)
		#print("body.velocity : ", body.velocity)
		
		if is_equal_approx(body.position.x, nextStop.x):
			# Calculer la nouvelle direction
			change_direction()
	elif orientation[0] == "z":
		if is_equal_approx(body.position.z, nextStop.z):
			# Calculer la nouvelle direction
			change_direction()

	# Bouger
	body.move_and_slide()
	
func change_direction():
	# Récupérer une direction aléatoire
	var direction;
	
	body.velocity = Vector3.ZERO
	if Input.is_action_just_pressed("p1_right"):
		if(!collideEast):
			if (addingBomb):
				var bomb_instance = bomb_instances[-1]
				#bomb_instance.position = body.position
				#b  omb_instance.position.x += 1
				get_parent().add_child(bomb_instance)
				addingBomb = false
			else:
				nextStop = Vector3.ZERO
				body.velocity.x = speed
				nextStop.x = body.position.x + step
				orientation = "x+"
				collideBottom = false
				collideTop = false
				collideWest = false
	elif Input.is_action_just_pressed("p1_left"):
		if(!collideWest):
			if (addingBomb):
				var bomb_instance = bomb_instances[-1]
				#bomb_instance.position = body.position
				#bomb_instance.position.x -= 1
				get_parent().add_child(bomb_instance)
				addingBomb = false
			else:
				nextStop = Vector3.ZERO
				nextStop.x = body.position.x - step
				body.velocity.x = -speed
				orientation = "x-"
				collideBottom = false
				collideTop = false
				collideEast = false
	elif Input.is_action_just_pressed("p1_backward"):
		if (!collideBottom):
			if (addingBomb):
				var bomb_instance = bomb_instances[-1]
				#bomb_instance.position = body.position
				#bomb_instance.position.z += 1
				get_parent().add_child(bomb_instance)
				addingBomb = false
			else:
				nextStop = Vector3.ZERO
				body.velocity.z = speed
				nextStop.z = body.position.z + step
				orientation = "z+"
				collideTop = false
				collideWest = false
				collideEast = false
	elif Input.is_action_just_pressed("p1_forward"):
		if(!collideTop):
			if (addingBomb):
				var bomb_instance = bomb_instances[-1]
				#bomb_instance.position = body.position
				#bomb_instance.position.z -= 1
				get_parent().add_child(bomb_instance)
				addingBomb = false
			else:
				nextStop = Vector3.ZERO
				body.velocity.z = -speed
				nextStop.z = body.position.z - step
				orientation = "z-"
				collideBottom = false
				collideWest = false
				collideEast = false

	if (
		Input.is_action_just_pressed("drop_bomb") 
		and bomb_instances.size() < max_bomb_instances
	):
		var bomb: Bomb = bomb_prefab.instantiate()
		bomb.explosion_range = explosion_range
		bomb.exploded.connect(_remove_bomb)
		bomb.position = body.position
		bomb.position.y = 1
		bomb_instances.append(bomb)
		addingBomb = true

func _remove_bomb(bomb: Bomb):
	bomb_instances.remove_at(0)

func _on_ray_north_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if (body.name != "Ground" and body.name != "CharacterBody3D"):	
		collideTop = true


func _on_ray_south_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if (body.name != "Ground" and body.name != "CharacterBody3D"):
		collideBottom = true


func _on_ray_west_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if (body.name != "Ground" and body.name != "CharacterBody3D"):
		collideWest = true

func _on_ray_east_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if (body.name != "Ground" and body.name != "CharacterBody3D"):
		collideEast = true

func add_range():
	explosion_range += 1
	
func add_max_bomb():
	max_bomb_instances += 1

func _on_body_entered(body: Node3D):
	if body.is_in_group("expend_explosion_bonus"):
		add_range()
	elif body.is_in_group("more_bomb_bonus"):
		add_max_bomb()
