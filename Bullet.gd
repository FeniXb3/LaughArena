extends RigidBody2D

const RIGHT = Vector2.RIGHT
@export var SPEED: int = 50

func _ready():
	var movement = RIGHT.rotated(rotation) * SPEED
	
	apply_impulse(movement)

func _physics_process(delta):
	var movement = RIGHT.rotated(rotation) * SPEED * delta
	#global_position += movement
	#apply_force(movement)
	

func destroy():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("Player"):
		destroy()
