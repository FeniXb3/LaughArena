extends RigidBody2D

@export var speed: float = 1
var input_direction = Vector2.ZERO

func get_input():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")


func _process(delta):
	get_input()

func _physics_process(delta):
	move_and_collide(input_direction * speed)
