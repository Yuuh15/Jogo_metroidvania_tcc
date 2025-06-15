extends State

@export var enemy : CharacterBody2D
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var timer: Timer = $"../../Timer"
@onready var ray_cast_2d: RayCast2D = $"../../vision"

func enter():
	sprite.play("follow")
	$"../../TrailTimer".wait_time = 0.1/3
	timer.start()

func physics_process(delta: float):
	
	if enemy.canWalk():
		enemy.direction = 1 if enemy.global_position.x < enemy.player.global_position.x else -1
		enemy.velocity.x = enemy.followSpeed * enemy.direction
	else:
		enemy.direction = -enemy.direction
		Transitioned.emit(self, "patrol")
	
	if ray_cast_2d.is_colliding():
		timer.start()
		
func _on_timer_timeout() -> void:
	Transitioned.emit(self, "patrol")
