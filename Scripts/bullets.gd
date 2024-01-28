extends RigidBody2D

var direction: Vector2 = Vector2.RIGHT
@export var damage: float = 1.0
#var speed: float = 300


func _on_screen_exited():
	queue_free()

func _on_body_entered(body):
	if !body is RigidBody2D:
		queue_free()
		return
	
	if body.collision_layer == 1:
		SignalBus.health_decreased.emit(damage)
	elif body.collision_layer == 4:
		print(body.name)
		body.queue_free()
	queue_free()


