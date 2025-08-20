extends State

@onready var player: Player = $"../.."

func enter():
	player.sprite.play("running")
	
func physics_process(delta: float) -> void:
	player.velocity.x = player.SPEED * player.directionX
	player.applyGravity(delta)
	
	# Altera para o estado 'idle'
	if player.directionX == 0:
		Transitioned.emit(self, "idle")
	
	elif Input.is_action_just_pressed("jump") || !player.is_on_floor():
		Transitioned.emit(self, "jump")
	
	elif Input.is_action_just_pressed("use_power"):
		if player.directionY > 0 && player.stomp:
			Transitioned.emit(self, "stomp")
		
		elif player.dash:
			Transitioned.emit(self, "dash")
