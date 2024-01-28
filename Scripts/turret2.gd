class_name Turret2
extends RigidBody2D 

@onready var ray_cast_2d = $RayCast2D
@onready var timer = $Timer
@export var ammo: PackedScene
@export var ammo_parent: Node
@export var BULLET_SPEED = 100

var player

func _ready():
	player = get_parent().find_child("player")
	
func _physics_process(_delta):
	_aim()
	
func _aim():
	ray_cast_2d.target_position = to_local(player.position)
	look_at(player.position)

func _on_timer_timeout():
	_shoot()
	timer.wait_time = randf_range(1, 5)
	
func _shoot():
	var bullet = ammo.instantiate()
	bullet.position = position
	bullet.direction = (ray_cast_2d.target_position).normalized()
	ammo_parent.add_child(bullet)
	bullet.apply_impulse(Vector2.RIGHT.rotated(rotation) * BULLET_SPEED)
	
