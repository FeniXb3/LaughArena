extends RigidBody2D

var direction: Vector2 = Vector2.RIGHT
#var speed: float = 300

#const RIGHT = Vector2.RIGHT
#@export var SPEED: int = 200

#func _ready():
	#var movement = RIGHT.rotated(rotation) * SPEED
	
	#apply_impulse(movement)

#func _physics_process(delta):
	#var movement = direction * SPEED * delta

#func _physics_process(delta):
	#position += direction * speed * delta


func _on_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.name == "player":
		var hitDirection = (body.transform.origin - transform.origin).normalized()
		body.apply_force(Vector2(hitDirection.x, hitDirection.y) * 500)
	queue_free()


