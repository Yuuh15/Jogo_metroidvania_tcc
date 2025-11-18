extends Node2D

@onready var up = $Sprite2D

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		up.visible = true
		body.canCredits = true
		


func _on_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		up.visible = false
		body.canCredits = false
