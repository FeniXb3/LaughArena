extends RigidBody2D
@export var action_key : String = "move_left"
@export var impulse_vector = Vector2(10000, 10000)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed(action_key):
		apply_impulse(impulse_vector)
