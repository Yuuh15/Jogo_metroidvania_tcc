extends State

@onready var player: Player = $"../.."
var jump_speed = -300

func enter():
	player.jump.play()
	player.sprite.play("jump")
	if player.is_on_floor():
		player.velocity.y = jump_speed
	elif player.airJumps > 0:
		player.velocity.y = jump_speed * 0.9
		player.airJumps -= 1
func physics_process(delta: float) -> void:
	if Input.is_action_just_released("jump") && player.velocity.y < 0:
		player.velocity.y = jump_speed / 4

	if Input.is_action_just_pressed("jump") && player.airJumps > 0:
		player.velocity.y = jump_speed * 0.9
		player.airJumps -= 1
		
	elif player.is_on_floor():
		Transitioned.emit(self, "idle")
		
	elif Input.is_action_just_pressed("use_power"):
		if player.directionY > 0 && player.stomp:
			Transitioned.emit(self, "stomp")
		
		elif player.dash:
			Transitioned.emit(self, "dash")
		
	else:
		player.velocity.x = player.SPEED * player.directionX
		
	player.applyGravity(delta)
