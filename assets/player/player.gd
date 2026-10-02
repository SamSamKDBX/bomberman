class_name Player
extends Node

@export var body: CharacterBody3D
@export var speed: int = 4
@export var ray_north: CollisionShape3D



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


func _ready() -> void:
	body.position = Vector3.ZERO
	nextStop = body.position
	collideEast = false
	
	
func _physics_process(delta: float) -> void:
	# Si on est arrivé à la prochaine étape

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
			nextStop = Vector3.ZERO
			body.velocity.x = speed
			nextStop.x = body.position.x + step
			orientation = "x+"
			collideBottom = false
			collideTop = false	
			collideWest = false
	elif Input.is_action_just_pressed("p1_left"):
		if(!collideWest):
			nextStop = Vector3.ZERO
			nextStop.x = body.position.x - step
			body.velocity.x = -speed
			orientation = "x-"
			collideBottom = false
			collideTop = false
			collideEast = false
	elif Input.is_action_just_pressed("p1_backward"):
		if (!collideBottom):
			nextStop = Vector3.ZERO
			body.velocity.z = speed
			nextStop.z = body.position.z + step
			orientation = "z+"
			collideTop = false
			collideWest = false
			collideEast = false
	elif Input.is_action_just_pressed("p1_forward"):		
		if(!collideTop):
			nextStop = Vector3.ZERO
			body.velocity.z = -speed
			nextStop.z = body.position.z - step
			orientation = "z-"
			collideBottom = false
			collideWest = false
			collideEast = false



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
