extends Control

var actualValue := 0.0
var previousValue := 0.0
var value: float

func _on_default_button_pressed() -> void:
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/options.tscn")
	previousValue = actualValue
	
	
func _on_h_slider_value_changed() -> void:
	value = 1.4
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _ready():
	for button in $PanelContainer/MarginContainer/VBoxContainer.get_children():
		button.connect("mouse_entered", $Switch.play)
		value = previousValue
		print("A")
		print(previousValue)
		value = 1.3
