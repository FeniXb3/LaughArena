extends Node2D
@export var enemy_scene: PackedScene
var rng = RandomNumberGenerator.new()


func _on_timer_timeout():
	var attempts = 0
	var max_attempts = 100  # Maximum number of attempts to find a valid location
	var spawned = false

	while not spawned and attempts < max_attempts:
		var x = randf_range(30, 330)
		var y = randf_range(30, 600)
		if (y>0):
			var enemy = enemy_scene.instantiate()
			enemy.position = Vector2(y, x)
			get_tree().current_scene.add_child(enemy)
			spawned = true
	
		else:
			attempts += 1
		
