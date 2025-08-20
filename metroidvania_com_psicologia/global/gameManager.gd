extends Node

var volumeValue = 1.5

func _ready() -> void:
	var actions = getInputActions()
	
	# Carrega as keyBinds salvas
	var config = ConfigFile.new()
	if config.load("user://inputs.cfg") == OK:
		for action in actions:
			InputMap.action_erase_events(action)
			var events = config.get_value("inputs", action)
			for key in events:
				InputMap.action_add_event(action, key)

		print("Inputs carregados")
	else:
		print("Nenhum save de inputs encontrado")
		
	# Carrega as configurações de audio
	if config.load("user://audio.cfg") == OK:
		volumeValue = config.get_value("audio", "masterVolume")
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volumeValue))
	else:
		print("Nenhum save de áudio encontrado")

	
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
