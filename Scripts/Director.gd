extends Node2D
@export var enemy_scene: PackedScene
@export var turrets_parent: Node
@export var ammo_parent: Node
var rng = RandomNumberGenerator.new()


func _on_timer_timeout():
	var attempts = 0
	var max_attempts = 100  # Maximum number of attempts to find a valid location
	var spawned = false
	var pos = $spawnery.get_child(randi()%$spawnery.get_child_count()).position
	var vec = (Vector2.ONE * randf_range(-50, 50)).rotated(randf_range(0, PI))
	
	while not spawned and attempts < max_attempts:
		if (1):
			var enemy = enemy_scene.instantiate()
			enemy.position = pos+vec
			(enemy as Turret2).ammo_parent = ammo_parent
			turrets_parent.add_child(enemy)
			spawned = true
	
		else:
			attempts += 1
		

