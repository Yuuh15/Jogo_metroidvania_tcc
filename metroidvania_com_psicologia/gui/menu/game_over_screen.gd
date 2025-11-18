extends Control

@onready var sfxSelectNormal = preload("res://audios/select.wav")

func _ready() -> void:
	modulate = Color(1, 1, 1, 0)
	visible = false

func resume():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	AudioPlayer.music_normal()
	$AnimationPlayer.play_backwards("blur")
	get_tree().paused = false
	await get_tree().create_timer(0.3).timeout
	$".".visible = false
	
func game_over():
	$".".visible = true
	$AnimationPlayer.play("blur")
	$background/VBoxContainer/exit.grab_focus()
	get_tree().paused = true
		
func _process(_delta: float) -> void:
	if Vars.gameOver == true:
		game_over()
		Vars.gameOver = false
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()
	
func _on_exit_pressed() -> void:
	resume()
	$"../../AnimationPlayer".play("game_over_exit")
	get_tree().change_scene_to_file("res://gui/scenes/main_menu.tscn")

func _on_button_mouse_entered() -> void:
	AudioPlayer.play_FX(sfxSelectNormal, -9.0)
