extends Control


func _on_controlls_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/input_settings.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/main_menu.tscn")
