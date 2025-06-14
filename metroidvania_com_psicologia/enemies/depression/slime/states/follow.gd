extends State

@export var enemy : CharacterBody2D
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var timer: Timer = $"../../Timer"
@onready var ray_cast_2d: RayCast2D = $"../../RayCast2D"

func enter():
	sprite.play("follow")
	$"../../TrailTimer".wait_time = 0.1/3
	timer.start()

func physics_process(delta: float):
	enemy.direction = 1 if enemy.global_position.x < enemy.player.global_position.x else -1
	enemy.velocity.x = enemy.followSpeed * enemy.direction
	if ray_cast_2d.is_colliding():
		timer.start()
		
func _on_timer_timeout() -> void:
	Transitioned.emit(self, "patrol")
