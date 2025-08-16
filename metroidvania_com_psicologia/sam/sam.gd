class_name Player
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var directionX : float
var directionY : float

var maxAirJumps = 1
var airJumps = 1

const SPEED = 150

func _process(delta: float) -> void:
	if directionX > 0:
		sprite.flip_h = false
	elif directionX < 0:
		sprite.flip_h = true
	
func _physics_process(delta: float) -> void:
	directionX = Input.get_axis("move_left", "move_right")
	move_and_slide()
	
func applyGravity(delta : float):
	if not is_on_floor():
		velocity += get_gravity() * delta
