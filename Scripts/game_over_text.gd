extends Label

func _ready():
	pass#SignalBus.game_over.connect(_on_game_over)
	
func _on_game_over():
	print("Game Over")
	visible = true
	get_tree().paused = true
