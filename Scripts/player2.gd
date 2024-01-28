extends RigidBody2D
class_name  Player

@onready var timer = $Timer
@export var speed: float = 1
@export var health_regeneration: float = 1
@export var max_mass = 1000
@export var min_mass = 0.01
var input_direction = Vector2.ZERO
@onready var area_2d = %Area2D
@export var push_force = 5000
@onready var deflection_timer = $DeflectionTimer
var can_deflect: bool = true
@onready var score_timer = $ScoreTimer
@export var score = 0
@export var score_added = 1
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var animation_locked = false
@onready var steps_sound = $Steps
@onready var bounce_sound = $Bounce
@onready var hurt_sound = $Hurt


func _ready():
	SignalBus.health_decreased.connect(_on_health_decreased)
	SignalBus.health_increased.connect(_on_health_increased)
	SignalBus.deflection_enabled.connect(_on_deflection_enabled)


func get_input():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	


func _on_health_decreased(value):
	mass = clamp(mass - value, min_mass, max_mass)
	hurt_sound.play()
	if mass <= 0.01:
		SignalBus.game_over.emit()
	animated_sprite.modulate = Color(2.04,0.2,0.7)
	await  get_tree().create_timer(0.1).timeout
	animated_sprite.modulate = Color.WHITE
	


func _on_health_increased(regen):
	mass = clamp(mass + regen, min_mass, max_mass)


func _process(_delta):
	get_input()
	update_animation()

func _physics_process(_delta):
	move_and_collide(input_direction * speed)
	
	if can_deflect && Input.is_action_just_pressed("Shoot"):
		animation_locked = true
		_deflection()
		animated_sprite.play("attack")
		await animated_sprite.animation_finished
		animation_locked = false


func _on_timer_timeout():
	SignalBus.health_increased.emit(health_regeneration)


func _deflection():
	var bulletsArray = area_2d.get_overlapping_bodies()
	for bullet in bulletsArray:
		var direction = (bullet.transform.origin - transform.origin)
		
		bullet.linear_velocity = Vector2.ZERO
		bullet.apply_impulse(direction * push_force)
		bullet.EmitParticle()
		bullet.collision_mask = bullet.collision_mask ^ 1 | 4
		SignalBus.ActiveParticle.emit()
		bounce_sound.play()
		score_added = 2
		score += score_added
		SignalBus.points_earned.emit(score_added)
		can_deflect = false
		SignalBus.deflection_performed.emit()
	deflection_timer.start()



func _on_deflection_enabled():
	can_deflect = true
	


func _on_score_timer_timeout():
	score_added = 1
	score += score_added
	SignalBus.points_earned.emit(score_added)
	
func update_animation():
	if animation_locked == false:
		if input_direction.y > 0:
			animated_sprite.play("walk down")
			if steps_sound.playing == false:
				steps_sound.play()
		elif input_direction.y < 0:
			animated_sprite.play("walk up")
			if steps_sound.playing == false:
				steps_sound.play()
		elif input_direction.x > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("walk side")
			if steps_sound.playing == false:
				steps_sound.play()
		elif input_direction.x < 0:
			animated_sprite.flip_h = true
			animated_sprite.play("walk side")
			if steps_sound.playing == false:
				steps_sound.play()
		else:
			animated_sprite.play("idle")
