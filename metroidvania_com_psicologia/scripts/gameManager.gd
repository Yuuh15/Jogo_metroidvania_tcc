extends Node

func _ready() -> void:
	var actions = getInputActions()
	# Carrega as keyBinds salvas
	var config = ConfigFile.new()
	#var actions = InputMap.get_actions()
	if config.load("user://inputs.cfg") == OK:
		for action in actions:
			InputMap.action_erase_events(action)
			var events = config.get_value("inputs", action)
			for key in events:
				InputMap.action_add_event(action, key)

		print("Inputs carregados")
	else:
		print("Nenhum save de inputs encontrado")

	
func getInputActions() -> Dictionary[String, String]:
	return {
		"jump": "Pular",
		"move_up": "Cima",
		"move_left": "Esquerda",
		"move_down": "Baixo",
		"move_right": "Direita",
		"use_power": "Poderes",
		"time_warp": "Distorção temporal"
	}
