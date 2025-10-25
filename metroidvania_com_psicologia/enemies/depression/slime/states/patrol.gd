extends State

@export var enemy : CharacterBody2D
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	enemy.speed = enemy.patrolSpeed
	sprite.play("default")
	$"../../TrailTimer".wait_time = 0.1
	
func physics_process(_delta : float):
	if (enemy.points[0] >= enemy.global_position.x and enemy.directionX == -1) or (enemy.points[1] <= enemy.global_position.x and enemy.directionX == 1):
		enemy.directionX = -enemy.directionX
	
	if enemy.ray_cast_2d.is_colliding():
		Transitioned.emit(self, "follow")

func _on_hurt_box_health_changed() -> void:
	Transitioned.emit(self, "follow")
