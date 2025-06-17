extends Control

@onready var input_button_scene = preload("res://gui/menu/input_button.tscn")
@onready var action_list: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remapping = false
var action_to_remap = null
var remapping_button = null

# Lista de ações personalizadas com nomes amigáveis
var input_actions = {
	"jump": "Pular",
	"move_left": "Esquerda",
	"move_right": "Direita",
	"use_power": "Poderes",
	"time_warp": "Distorção temporal"
}

func _ready() -> void:
	_create_action_list()

func _create_action_list():
	InputMap.load_from_project_settings()  # Recarrega mapeamento base
	for item in action_list.get_children():
		item.queue_free()

	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]

		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""

		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Pressione uma tecla..."

func _input(event):
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			_save_input_config()

			is_remapping = false
			action_to_remap = null
			remapping_button = null

			accept_event()

func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")

func _save_input_config():
	var config = ConfigFile.new()

	for action in input_actions:
		var events = InputMap.action_get_events(action)
		if events.size() > 0 and events[0] is InputEventKey:
			var event = events[0] as InputEventKey
			config.set_value("inputs", action, event.keycode)

	config.save("user://input.cfg")

func _on_botão_padrão_pressed() -> void:
	_create_action_list()

func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/menu/opções.tscn")
