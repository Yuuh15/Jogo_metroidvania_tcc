class_name HurtBox
extends Area2D

@export var health : int = 100

signal healthChanged
signal die

func takeDamage():
	healthChanged.emit()
	var sprite = get_parent() as Node2D
	var tween = create_tween()
	
	if 0 >= health:
		die.emit()
		queue_free()
		return

	tween.tween_property(sprite, "modulate", Color.RED, 0.25)
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.25)
