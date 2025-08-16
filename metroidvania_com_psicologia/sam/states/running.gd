extends State

@onready var player: Player = $"../.."

func enter():
	player.sprite.play("running")
	
func physics_process(delta: float) -> void:
	player.velocity.x = player.SPEED * player.directionX
	
	# Altera para o estado 'idle'
	if player.directionX == 0:
		Transitioned.emit(self, "idle")
	
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "jump")
	
	player.applyGravity(delta)
