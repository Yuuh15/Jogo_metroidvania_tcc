extends Area2D

@onready var anim = $"../transparent_floor"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		anim.play("opacity_down")
		queue_free()
