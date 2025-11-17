extends State

@onready var player: Player = $"../.."


func enter():
	player.sprite.play("jump")
	if player.is_on_floor():
		player.velocity.y = player.jump_speed
		player.jump.play() # Toca o som de pulo normal
	elif player.airJumps > 0 && Input.is_action_just_pressed("jump"):
		player.velocity.y = player.jump_speed * 0.9
		player.airJumps -= 1
		player.highJump.play()

func physics_process(delta: float) -> void:
	player.applyGravity(delta)
	if Input.is_action_just_released("jump") && player.velocity.y < 0 && !player.wallJumping:
		player.velocity.y = player.jump_speed / 4

	if Input.is_action_just_pressed("jump") && player.airJumps > 0:
		player.velocity.y = player.jump_speed * 0.9
		player.airJumps -= 1
		player.highJump.play()
	
	if player.wall_detector.is_colliding():
		Transitioned.emit(self, "grip")
		player.wallJumping = false
		player.gDirection *= -1
		
	if player.is_on_floor():
		Transitioned.emit(self, "idle")
		player.wallJumping = false
	
	elif Input.is_action_just_pressed("use_power"):
		if player.directionY > 0 && player.stomp:
			Transitioned.emit(self, "stomp")
		
		elif player.dash:
			Transitioned.emit(self, "dash")
		
	else:
		player.velocity.x = player.SPEED * player.directionX
	
