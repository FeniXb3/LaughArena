extends Node2D
@export var enemy_scene: PackedScene
@export var turrets_parent: Node
@export var ammo_parent: Node
var rng = RandomNumberGenerator.new()


func _on_timer_timeout():
	var attempts = 0
	var max_attempts = 100  # Maximum number of attempts to find a valid location
	var spawned = false

	while not spawned and attempts < max_attempts:
		var x = randf_range(30, 330)
		var y = randf_range(30, 600)
		if (1):
			var enemy = enemy_scene.instantiate()
			enemy.position = Vector2(y, x)
			(enemy as Turret2).ammo_parent = ammo_parent
			turrets_parent.add_child(enemy)
			spawned = true
	
		else:
			attempts += 1
		
