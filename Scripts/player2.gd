extends RigidBody2D

@export var speed: float = 1

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	linear_velocity = input_direction * speed
	return linear_velocity

func _physics_process(delta):
	move_and_collide(get_input())
