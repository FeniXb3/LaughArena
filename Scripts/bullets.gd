extends RigidBody2D

var direction: Vector2 = Vector2.RIGHT
@export var damage: float = 1.0
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
	if !body is RigidBody2D:
		return
	
	if body.collision_layer == 1:
		SignalBus.health_decreased.emit(damage)
	elif body.collision_layer == 4:
		print(body.name)
		body.queue_free()
	queue_free()


