extends RigidBody2D

@onready var ray_cast_2d = $RayCast2D
@onready var timer = $Timer
@export var ammo: PackedScene
var   BULLET_SPEED = 100

var player

func _ready():
	player = get_parent().find_child("player")
	
func _physics_process(_delta):
	_aim()
	#_check_player_collision()
	
func _aim():
	ray_cast_2d.target_position = to_local(player.position)
	look_at(player.position)
	
#func _check_player_collision():
	#if ray_cast_2d.get_collider() == player and timer.is_stopped():
		#timer.start()
	#elif ray_cast_2d.get_collider() != player and not timer.is_stopped():
		#timer.stop()

func _on_timer_timeout():
	_shoot()
	
func _shoot():
	var bullet = ammo.instantiate()
	bullet.position = position
	bullet.direction = (ray_cast_2d.target_position).normalized()
	get_tree().current_scene.add_child(bullet)
	bullet.apply_impulse(Vector2.RIGHT.rotated(rotation) * BULLET_SPEED)
	
