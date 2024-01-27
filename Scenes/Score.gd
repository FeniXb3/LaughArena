extends Label
var score = 0

func update_score():
	text = "Score: " + str(score) 

func _ready():
	SignalBus.points_earned.connect(_on_points_earned)
	
func _on_points_earned(value):
	score += value
	update_score()
