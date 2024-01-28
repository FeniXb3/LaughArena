extends ProgressBar

@onready var deflection_timer = $"../DeflectionTimer"
@onready var player = $".."

func _ready():
	SignalBus.deflection_performed.connect(_on_deflection_performed)


	

func _on_deflection_performed():
	value = min_value


func _on_deflection_timer_timeout():
	value = clamp(value + step, min_value, max_value)
	
	if value == max_value:
		SignalBus.deflection_enabled.emit()
