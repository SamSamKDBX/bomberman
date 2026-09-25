extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("p1_left"):		
		apply_central_force(Vector3(-15, 0, 0))
	if Input.is_action_just_pressed("p1_right"):
		apply_central_force(Vector3(15, 0, 0))
	if Input.is_action_just_pressed("p1_forward"):
		apply_central_force(Vector3(0, 0, -15))
	if Input.is_action_just_pressed("p1_backward"):
		apply_central_force(Vector3(0, 0, 15))
