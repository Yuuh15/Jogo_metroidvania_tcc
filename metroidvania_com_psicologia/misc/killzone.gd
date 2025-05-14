extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("You died!")
		Engine.time_scale = 1
		$Timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
