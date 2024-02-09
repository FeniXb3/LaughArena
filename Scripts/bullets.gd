extends RigidBody2D
class_name Bullet

var direction: Vector2 = Vector2.RIGHT
@export var damage: float = 1.0
@export var push_force: float = 500
@export var deflected_color: Color = Color.CHOCOLATE
@onready var Particle = $GPUParticles2D
@onready var sprite_2d = $Sprite2D
@onready var mark = $Sprite2D/Mark


#var speed: float = 300


func _on_screen_exited():
	queue_free()

func _on_body_entered(body):
	if not (body is RigidBody2D):
		queue_free()
		return
	
	if body.collision_layer == 1:
		SignalBus.health_decreased.emit(damage)
		SignalBus.player_was_hit.emit()
		var direction = (body.transform.origin - transform.origin)
		body.apply_impulse(direction * push_force)
	elif body.collision_layer == 4:
		print(body.name)
		body.queue_free()
	queue_free()

#func _ready():
	#SignalBus.ActiveParticle.connect(EmitParticle)
	
func EmitParticle():
	Particle.emitting = true
	
func deflect(impulse):
	linear_velocity = Vector2.ZERO
	apply_impulse(impulse)
	EmitParticle()
	collision_mask = collision_mask ^ 1 | 4
	sprite_2d.modulate = deflected_color
	mark.show()
	SignalBus.ActiveParticle.emit()
	
