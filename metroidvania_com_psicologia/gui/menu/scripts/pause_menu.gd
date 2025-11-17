extends Control

func _ready() -> void:
	modulate = Color(1, 1, 1, 0)
	visible = false

func resume():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$AnimationPlayer.play_backwards("blur")
	get_tree().paused = false
	await get_tree().create_timer(0.3).timeout
	$".".visible = false

func pause():
	$".".visible = true
	$AnimationPlayer.play("blur")
	$background/VBoxContainer/back.grab_focus()
	get_tree().paused = true

func getEsc():
	if Input.is_action_just_pressed("pause_game") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause_game") and get_tree().paused:
		resume()
		
func _process(_delta: float) -> void:
	getEsc()
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_back_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()
	
func _on_options_pressed() -> void:
	visible = false

func _on_exit_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://gui/menu/main_menu.tscn")

func _on_button_mouse_entered() -> void:
	AudioPlayer.play_FX(AudioPlayer.sfxSelectNormal, -9.0)
