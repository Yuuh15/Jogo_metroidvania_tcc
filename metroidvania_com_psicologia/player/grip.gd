extends State

@onready var player = $"../.."

func enter():
	player.velocity.y = 0
	
func physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("jump"):
		player.wallJumping = true
		player.velocity.x += 75 * player.gDirection
		player.velocity.y += player.jump_speed/1.1
		player.sprite.scale.x = player.gDirection * 0.38
		
		Transitioned.emit(self, "idle")
	
	if player.directionX == player.gDirection:
		player.velocity.x += player.SPEED * player.gDirection
		Transitioned.emit(self, "idle")
func exit():
	pass
		
