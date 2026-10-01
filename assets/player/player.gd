class_name Player
extends Node

@export var body: CharacterBody3D
@export var speed: int = 4
@export var ray_north: MeshInstance3D



var rng = RandomNumberGenerator.new()
var nextStop: Vector3
var step: int = 1
var ray_length : int = 1
var bombs_capacity: int
var orientation = "x+"


func _ready() -> void:
	body.position = Vector3.ZERO
	nextStop = body.position
	
	
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
		nextStop = Vector3.ZERO
		body.velocity.x = speed
		nextStop.x = body.position.x + step
		orientation = "x+"
	elif Input.is_action_just_pressed("p1_left"):
		nextStop = Vector3.ZERO
		nextStop.x = body.position.x - step
		body.velocity.x = -speed
		orientation = "x-"
	elif Input.is_action_just_pressed("p1_backward"):
		nextStop = Vector3.ZERO
		body.velocity.z = speed
		nextStop.z = body.position.z + step
		orientation = "z+"
	elif Input.is_action_just_pressed("p1_forward"):
		print("try forward")
		nextStop = Vector3.ZERO
		body.velocity.z = -speed
		nextStop.z = body.position.z - step
		orientation = "z-"
