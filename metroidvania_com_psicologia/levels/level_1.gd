extends Node2D

@onready var health_bar = $CanvasLayer/HealthBar

func _ready() -> void:
	AudioPlayer.play_music_level1()
	health_bar.visible = true
