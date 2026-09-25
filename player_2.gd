extends CharacterBody3D


const SPEED = 50.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("p1_left"):		
		velocity.x = (-1) * SPEED
		move_and_slide()
		velocity.x = 0
	if Input.is_action_just_pressed("p1_right"):
		velocity.x = SPEED
		move_and_slide()
		velocity.x = 0
	if Input.is_action_just_pressed("p1_forward"):
		velocity.z = (-1) * SPEED
		move_and_slide()
		velocity.z = 0.0
	if Input.is_action_just_pressed("p1_backward"):
		velocity.z = SPEED
		move_and_slide()
		velocity.z = 0.0
	

