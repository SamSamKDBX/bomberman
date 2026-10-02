extends Camera3D

const SPEED = 1.0
var step: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var position_player = get_parent().get_child(3).position;
	position.z = position_player.z + 4 ;
	position.y = position_player.y + 6
	position.x = position_player.x - 0.5
