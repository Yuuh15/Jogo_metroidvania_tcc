extends Node2D



func _on_timer_timeout() -> void:
	$AnimationPlayer.play("trail")
