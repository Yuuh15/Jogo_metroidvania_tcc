extends State

@onready var player : Player = $"../.."

func enter():
	if player.sprite != null:
		player.sprite.play("idle")
	player.velocity.x = move_toward(player.velocity.x,0, player.SPEED)

func physics_process(delta):
	# Altera para o estado 'running'
	if player.directionX != 0:
		Transitioned.emit(self, "running")
		
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "jump")
		
	player.applyGravity(delta)
