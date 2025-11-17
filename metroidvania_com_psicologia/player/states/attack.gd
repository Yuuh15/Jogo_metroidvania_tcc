extends State

@onready var player: Player = $"../.."
var direction : int

func enter():
	direction = player.sprite.scale.x
	player.attackShape.visible = true
	player.sprite.play("attack")
	player.attackShape.disabled = false
	
func physics_process(delta: float) -> void:
	player.velocity.x = player.SPEED * player.directionX
	player.applyGravity(delta)
	
	if !player.sprite.is_playing():			
		if player.directionX != 0:
			Transitioned.emit(self, "running")
		else:
			Transitioned.emit(self, "idle")
		return
	elif Input.is_action_just_pressed("jump") || !player.is_on_floor():
		Transitioned.emit(self, "jump")
		
	elif Input.is_action_just_pressed("use_power"):
		if player.directionY > 0 && player.stomp:
			Transitioned.emit(self, "stomp")
		elif player.dash:
			Transitioned.emit(self, "dash")
			
func exit():
	player.attackShape.disabled = true
	player.attackShape.visible = false
