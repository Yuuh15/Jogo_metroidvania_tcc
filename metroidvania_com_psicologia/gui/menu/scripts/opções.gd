extends Control

func _ready() -> void:
	for button in $VBoxContainer.get_children():
		button.connect("mouse_entered", $Switch.play)

func _on_audio_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/audio_settings.tscn")
	

func _on_controlls_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/input_settings.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/main_menu.tscn")
