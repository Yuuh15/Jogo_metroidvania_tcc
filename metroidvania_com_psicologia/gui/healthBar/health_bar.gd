extends ProgressBar

@export var target : CharacterBody2D

func _ready() -> void:
	target.healthChanged.connect(healthUpdate)
	healthUpdate()

func healthUpdate():
	value = target.health
