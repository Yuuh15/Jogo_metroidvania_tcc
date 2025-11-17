extends State

@onready var player : Player = $"../.."

func enter():
	if player.sprite != null:
		player.sprite.play("idle")

func physics_process(delta):
	if player.directionX != 0:
		Transitioned.emit(self, "running")
		
	elif player.canSave && Input.is_action_just_pressed("move_up"):
		player.save()
		
	elif Input.is_action_just_pressed("jump") || !player.is_on_floor():
		Transitioned.emit(self, "jump")
	
	elif Input.is_action_just_pressed("use_power"):
		if player.directionY > 0 && player.stomp:
			Transitioned.emit(self, "stomp")
		
		elif player.dash:
			Transitioned.emit(self, "dash")
	
	elif Input.is_action_just_pressed("ataque"):
		Transitioned.emit(self, "attack")
	
	
	player.velocity.x = move_toward(player.velocity.x,0, player.SPEED)
	player.applyGravity(delta)
