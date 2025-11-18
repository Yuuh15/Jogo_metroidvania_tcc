extends Node2D

var amplitude = 4
var speed = 2.0
var start_y : float

func _ready():
	await get_tree().process_frame
	start_y = position.y

func _process(delta):
	# flutuação
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hurt_box.health += 30
		body.hurt_box.heal.emit()
		if body.hurt_box.health > 200:
			body.hurt_box.health = 200
		AudioPlayer.sfx_heal()
		queue_free()
