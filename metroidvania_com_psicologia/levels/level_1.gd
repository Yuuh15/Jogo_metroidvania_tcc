extends Node2D

@onready var health_bar = $CanvasLayer/HealthBar
@onready var pause_menu = $PauseMenu/pause_menu

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	AudioPlayer.play_music_level1()
	health_bar.visible = true
	pause_menu.visible = false

func _on_opacity_down_floor_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
