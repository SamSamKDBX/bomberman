extends Node

@export var body: CharacterBody3D
@export var speed: int = 1
@export var timer: Timer
@export var eyes: MeshInstance3D

var rng = RandomNumberGenerator.new()
var nextStop: Vector3
var step: int = 2
var ray_length: int = 1

func _ready() -> void:
	nextStop = body.position
	timer.start()
	
func _physics_process(_delta: float) -> void:
	# Si on est arrivé à la prochaine étape
	if body.position == nextStop:
		# Calculer la nouvelle direction
		random_velocity()
	# Bouger
	body.move_and_slide()

func random_velocity():
	# Récupérer une direction aléatoire
	var direction = randi() % 4
	
	# Remettre la vélocité et la prochaine étape à 0
	body.velocity = Vector3.ZERO
	nextStop = Vector3.ZERO
	
	# Appliquer la vélocité et la prochaine étape 
	# en fonction de la direction
	match direction:
		0: 
			body.velocity.x = speed
			nextStop.x = body.position.x + step
		1: 
			body.velocity.x = -speed
			nextStop.x = body.position.x - step
		2: 
			body.velocity.z = speed
			nextStop.x = body.position.z + step
		3: 
			body.velocity.z = -speed
			nextStop.x = body.position.z - step
