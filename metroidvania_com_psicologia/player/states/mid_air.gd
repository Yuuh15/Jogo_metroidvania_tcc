extends State

@onready var player: Player = $"../.."
@onready var walljump: CollisionShape2D = $"../../walljump"
@onready var wall_detector: RayCast2D = $"../../AnimatedSprite2D/WallDetector"

func enter():
	player.sprite.play("climb")
	player.sprite.frame = 0
	player.sprite.pause()

func physics_process(delta: float) -> void:
	player.applyGravity(delta)
	
	if player.wall_detector.is_colliding() and player.claws == true:
		Transitioned.emit(self, "grip")
		player.wallJumping = false
		player.gDirection *= -1
		
		player.sprite.play("climb")
		player.sprite.frame = 1
		player.sprite.pause()
		
		walljump.disabled = false
	
	if player.is_on_floor():
		Transitioned.emit(self, "idle")
		player.wallJumping = false
		walljump.disabled = true
		wall_detector.target_position.x = 6

func exit():
	pass
