extends State

@onready var player: Player = $"../.."

func enter():
	pass

func physics_process(delta: float) -> void:
	player.applyGravity(delta)
	
	if player.wall_detector.is_colliding():
		Transitioned.emit(self, "grip")
		player.wallJumping = false
		player.gDirection *= -1
	
	if player.is_on_floor():
		Transitioned.emit(self, "idle")
		player.wallJumping = false

func exit():
	pass
