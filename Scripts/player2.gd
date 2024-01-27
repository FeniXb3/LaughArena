extends RigidBody2D

@onready var timer = $Timer
@export var speed: float = 1
@export var health_regeneration: float = 1
@export var max_mass = 1000
@export var min_mass = 0.01
var input_direction = Vector2.ZERO

func _ready():
	SignalBus.health_decreased.connect(_on_health_decreased)
	SignalBus.health_increased.connect(_on_health_increased)
	
func get_input():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _on_health_decreased(value):
	mass = clamp(mass - value, min_mass, max_mass)
			
func _on_health_increased(regen):
	mass = clamp(mass + regen, min_mass, max_mass)

func _process(delta):
	get_input()

func _physics_process(delta):
	move_and_collide(input_direction * speed)


func _on_timer_timeout():
	SignalBus.health_increased.emit(health_regeneration)
