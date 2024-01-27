extends RigidBody2D

@onready var timer = $Timer
@export var speed: float = 1
@export var health_regeneration: float = 1
@export var max_mass = 1000
@export var min_mass = 0.01
var input_direction = Vector2.ZERO
@onready var area_2d = %Area2D
@export var push_force = 1000
@onready var deflection_timer = $DeflectionTimer
var can_deflect: bool = true

func _ready():
	SignalBus.health_decreased.connect(_on_health_decreased)
	SignalBus.health_increased.connect(_on_health_increased)


func get_input():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")


func _on_health_decreased(value):
	mass = clamp(mass - value, min_mass, max_mass)
	if mass <= 0.01:
		SignalBus.game_over.emit()


func _on_health_increased(regen):
	mass = clamp(mass + regen, min_mass, max_mass)


func _process(_delta):
	get_input()


func _physics_process(_delta):
	move_and_collide(input_direction * speed)
	
	if can_deflect && Input.is_action_just_pressed("Shoot"):
		_deflection()


func _on_timer_timeout():
	SignalBus.health_increased.emit(health_regeneration)


func _deflection():
	var bulletsArray = area_2d.get_overlapping_bodies()
	for bullet in bulletsArray:
		var direction = (bullet.transform.origin - transform.origin)
		
		bullet.linear_velocity = Vector2.ZERO
		bullet.apply_impulse(direction * push_force)
		
		can_deflect = false


func _on_deflection_timer_timeout():
	can_deflect = true
	deflection_timer.start()
