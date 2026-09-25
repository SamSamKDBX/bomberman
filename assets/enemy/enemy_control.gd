extends Node

@export var body: CharacterBody3D
@export var speed: int = 1
@export var timer: Timer
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	timer.start()
	
func _physics_process(delta: float) -> void:
	# Bouger
	body.move_and_slide()

func random_velocity():
	# Récupérer une direction aléatoire
	var direction = randi() % 4
	
	# Remettre la vélocité à 0
	body.velocity = Vector3.ZERO
	
	# Appliquer la vélocité en fonction de la direction
	match direction:
		0: body.velocity.x = speed
		1: body.velocity.x = -speed
		2: body.velocity.z = speed
		3: body.velocity.z = -speed
	
