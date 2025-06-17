extends Control


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/main_menu.tscn")
	

	


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/input_settings.tscn")
