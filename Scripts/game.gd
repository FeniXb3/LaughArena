extends Node2D

@export var level_scene : PackedScene
@onready var menu_layer = $MenuLayer
@onready var main_menu = $MenuLayer/MainMenu
@onready var pause_menu = $MenuLayer/PauseMenu

@onready var level_parent = $LevelParent
var level : Node

func _input(event):
	if (event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause")) and not pause_menu.visible:
		pause_menu.open_pause_menu()

func _on_main_menu_start_game_pressed():
	if level:
		get_tree().root.remove_child(level)
		level.free()
	
	level = level_scene.instantiate()
	get_tree().root.add_child(level)
	print("start")
	main_menu.visible = false
	
