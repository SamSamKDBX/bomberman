extends CharacterBody3D


const SPEED = 1.0
var step: int = 1

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_left"):		
		velocity.x = (-1) * SPEED
		position.x = position.x - step
		move_and_slide()
	if Input.is_action_just_pressed("p1_right"):
		velocity.x = SPEED
		position.x = position.x + step
		move_and_slide()
	if Input.is_action_just_pressed("p1_forward"):
		velocity.z = (-1) * SPEED
		position.z = position.z - step
		move_and_slide()
	if Input.is_action_just_pressed("p1_backward"):
		velocity.z = SPEED
		position.z = position.z + step
		move_and_slide()
	
