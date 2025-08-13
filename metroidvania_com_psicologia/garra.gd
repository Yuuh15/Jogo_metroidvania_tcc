extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.grip_wall = true
	
func _on_body_exited(body: Node2D) -> void:
	body.grip_wall = false
