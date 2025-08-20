extends Node2D

var amplitude = 4
var speed = 2.0
var start_y : float

func _ready():
	start_y = position.y

func _process(delta):
	# flutuação
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude
	
	# pulsar escala
	var scale_factor = 1.0 + (sin(Time.get_ticks_msec() / 1000.0 * speed) * 0.05) # varia entre 0.9 e 1.1
	scale = Vector2(scale_factor, scale_factor)

func _on_player_detection_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Player:
		body.stomp = true
		queue_free() # Replace with function body.
