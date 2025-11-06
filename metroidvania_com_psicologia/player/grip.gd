extends State

@onready var player = $"../.."

func enter():
	player.velocity.y = 0
	
func physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("jump"):
		player.velocity.x += 100 * player.gDirection
		player.velocity.y += player.jump_speed
		player.sprite.scale.x = player.gDirection * 0.38
		Transitioned.emit(self, "jump")
		
func exit():
	pass
		
