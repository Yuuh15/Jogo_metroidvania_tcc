extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AudioPlayer.play_music_menu()
	for button in $VBoxContainer.get_children():
		button.connect("mouse_entered", $Switch.play)
		
func _process(delta):
	pass

func _on_start_pressed() -> void:
	AudioPlayer.stop()
	var config = ConfigFile.new()
	var sceneToLoad = "res://levels/level_1.tscn"
	get_tree().change_scene_to_file(sceneToLoad)

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/options.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
