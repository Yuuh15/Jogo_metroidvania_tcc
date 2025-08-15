extends Node

func _ready() -> void:
	# Carrega as keyBinds salvas
	var config = ConfigFile.new()
	var actions = InputMap.get_actions()
	if config.load("res://saveTest/inputs.cfg") == OK:
		for action in actions:
			InputMap.action_erase_events(action)
			var event = config.get_value("inputs", action)
			if event is Array:
				for key in event:
					InputMap.action_add_event(action, key)
			else:
				InputMap.action_add_event(action, event)
		print("Inputs carregados")
	else:
		print("Nenhum save de inputs encontrado")

	
