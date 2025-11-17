class_name Door
extends Node2D

@export var next_door: Door

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.canSave = true
		body.door_to = next_door.global_position


func _on_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.canSave = false
