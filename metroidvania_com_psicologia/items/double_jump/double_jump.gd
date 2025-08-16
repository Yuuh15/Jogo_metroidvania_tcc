extends Node2D

func _on_player_detection_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	body.maxAirJumps = 2
	queue_free()
