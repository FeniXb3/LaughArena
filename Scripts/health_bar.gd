extends ProgressBar

func _ready():
	SignalBus.health_decreased.connect(_on_health_decreased)
	SignalBus.health_increased.connect(_on_health_increased)

func _on_health_decreased(damage):
	value = clamp(value - damage, min_value, max_value)
	
func _on_health_increased(regen):
	value = clamp(value + regen, min_value, max_value)
