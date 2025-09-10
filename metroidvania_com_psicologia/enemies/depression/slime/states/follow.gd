extends State

@export var enemy : CharacterBody2D
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var timer: Timer = $"../../Timer"
@onready var ray_cast_2d: RayCast2D = $"../../vision"

func enter():
	sprite.play("follow")
	$"../../TrailTimer".wait_time = 0.1 / 4
	timer.start()
	enemy.speed = enemy.followSpeed

func physics_process(delta: float):
	if enemy.canWalk():
		enemy.directionX = 1 if enemy.global_position.x < enemy.player.global_position.x else -1
	else:
		enemy.directionX = -enemy.directionX
		Transitioned.emit(self, "patrol")
	
	if ray_cast_2d.is_colliding():
		timer.start()
		
func _on_timer_timeout() -> void:
	Transitioned.emit(self, "patrol")
