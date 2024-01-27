extends Control
signal start_game_pressed

@onready var start_game_button: Button = $%StartGameButton

@onready var content : VBoxContainer = $%Content
@onready var options_menu : Control = $%OptionsMenu
	
func open_menu():
	#Stops game and shows pause menu
	get_tree().paused = true
	show()
	start_game_button.grab_focus()

func close_menu():
	get_tree().paused = false
	hide()
	#emit_signal("resume")

func _on_options_button_pressed():
	content.hide()
	options_menu.show()
	options_menu.on_open()


func _on_options_menu_close():
	options_menu.hide()
	content.show()
	start_game_button.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()


func _on_start_game_button_pressed():
	start_game_pressed.emit()
	close_menu()
