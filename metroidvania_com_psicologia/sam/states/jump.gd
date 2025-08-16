extends State

@onready var player: Player = $"../.."
var jump_speed = -300
const gravity = 980
var maxHeight : float

func enter():
	player.sprite.play("jump")
	maxHeight = player.position.y - 250
	player.velocity.y = jump_speed
	
func physics_process(delta: float) -> void:
	if Input.is_action_just_released("jump") && player.velocity.y < 0:
		player.velocity.y = jump_speed / 4
	
	if Input.is_action_just_pressed("jump") && player.airJumps > 0:
		player.velocity.y = jump_speed
		player.airJumps -= 1
	
	if player.is_on_floor():
		Transitioned.emit(self, "idle")
		
	player.velocity.x = player.SPEED * player.directionX
	
	player.applyGravity(delta)
	
func exit():
	player.airJumps = player.maxAirJumps
	
