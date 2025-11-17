extends State

@export var enemy : CharacterBody2D

func enter():
	var sprite = enemy.sprite as AnimatedSprite2D
	sprite.play("die")
	sprite.animation_finished.connect(enemy.queue_free)
