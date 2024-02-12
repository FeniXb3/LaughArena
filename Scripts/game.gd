extends Node2D

@export var ommit_start_menu = false
@export var level_scene : PackedScene
@onready var menu_layer = $MenuLayer
@onready var main_menu = %MainMenu
@onready var pause_menu = %PauseMenu
@onready var game_over_menu = %GameOverMenu
@onready var music_sound = $Music
@onready var game_over_screen_delay = 3.0

@onready var level_parent = $LevelParent
var level : Node

@onready var king_laugh_1 = $KingLaugh1
@onready var king_laugh_2 = $KingLaugh2
@onready var king_laugh_3 = $KingLaugh3
@onready var king_laugh_4 = $KingLaugh4
@onready var king_laugh_5 = $KingLaugh5
var sounds : Array

@onready var crowd_laugh_1 = $CrowdLaugh1


func _ready():
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.player_was_hit.connect(_on_player_was_hit)
	sounds = [king_laugh_1, king_laugh_2, king_laugh_3, king_laugh_4, king_laugh_5]
	
	if ommit_start_menu:
		_on_main_menu_start_game_pressed()
	else:
		music_sound.play()
		music_sound.pitch_scale = 0.5

func _input(event):
	if (event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause")) and not pause_menu.visible:
		pause_menu.open_pause_menu()

func _on_main_menu_start_game_pressed():
	clear_level()
	
	level = level_scene.instantiate()
	level_parent.add_child(level)
	print("start")
	music_sound.play()
	music_sound.pitch_scale = 1
	
	main_menu.hide()
	#music_sound.volume_db = -25
	#music_sound.pitch_scale = 2
	SignalBus.game_started.emit()

func _on_game_over():
	#main_menu.open_main_menu()
	crowd_laugh_1.play()
	await get_tree().create_timer(game_over_screen_delay).timeout
	game_over_menu.open_menu()
	
	#pause_menu.open_pause_menu()

func clear_level():
	if level:
		level_parent.remove_child(level)
		level.free()

func _on_player_was_hit():
	_play_random_sound()

func _play_random_sound():
	
	var sound_index = randi() % 5 
	
	var sound = sounds[sound_index]
	
	print(sound.name)
	sound.play()
