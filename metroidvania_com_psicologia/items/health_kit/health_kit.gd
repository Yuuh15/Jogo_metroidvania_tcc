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
	var scale_factor = 0.5 + (sin(Time.get_ticks_msec() / 1000.0 * speed) * 0.05) # varia entre 0.9 e 1.1
	scale = Vector2(scale_factor, scale_factor)

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hurt_box.health += 25
		body.hurt_box.heal.emit()
		if body.hurt_box.health > 100:
			body.hurt_box.health = 100
		AudioPlayer.sfx_heal()
		queue_free()
