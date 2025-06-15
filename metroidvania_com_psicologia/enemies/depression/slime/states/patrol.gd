extends State

@export var enemy : CharacterBody2D
@onready var ray_cast_2d: RayCast2D = $"../../vision"
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	enemy.speed = enemy.patrolSpeed
	sprite.play("default")
	$"../../TrailTimer".wait_time = 0.1
	
func physics_process(_delta : float):
	if (enemy.points[0] >= enemy.global_position.x and enemy.direction == -1) or (enemy.points[1] <= enemy.global_position.x and enemy.direction == 1):
		enemy.direction = -enemy.direction
	
	if ray_cast_2d.is_colliding():
		Transitioned.emit(self, "follow")
