extends Control



func _ready():
	pass
	
	
	
func _process(delta):
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/test_level.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/opções.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
