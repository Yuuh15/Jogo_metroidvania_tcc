extends Control

func _ready():
	for button in $VBoxContainer.get_children():
		button.connect("mouse_entered", $Switch.play)
		
func _process(delta):
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/lvl_1.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/opções.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
