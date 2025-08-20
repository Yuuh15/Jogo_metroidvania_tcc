extends Control

var actualValue = 5

func _ready():
	for button in $PanelContainer/MarginContainer/VBoxContainer.get_children():
		button.connect("mouse_entered", $Switch.play)
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/HSlider.value = actualValue
	print(actualValue)
	
func _on_default_button_pressed() -> void:
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/options.tscn")

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	actualValue = value
	print(actualValue)
