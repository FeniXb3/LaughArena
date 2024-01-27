extends Node2D
@export var enemy_scene: PackedScene
@export var turrets_parent: Node
@export var ammo_parent: Node
@onready var timer = $Timer
var rng = RandomNumberGenerator.new()
var credits = 3

func _on_timer_timeout():
	credits +=3
	while credits>=1:
		var pos = $spawnery.get_child(randi()%$spawnery.get_child_count()).position
		var vec = (Vector2.ONE * randf_range(-50, 50)).rotated(randf_range(0, PI))

		var enemy = enemy_scene.instantiate()
		enemy.position = pos+vec
		(enemy as Turret2).ammo_parent = ammo_parent
		turrets_parent.add_child(enemy)
		credits -=1
		

