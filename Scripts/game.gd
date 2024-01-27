extends Node2D

@onready var level = $bullethell

func _on_main_menu_start_game_pressed():
	level.visible = true
	level.process_mode = Node.PROCESS_MODE_INHERIT
