extends State

@export var enemy : CharacterBody2D
@onready var ray_cast_2d: RayCast2D = $"../../vision"
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
var points : Array[int]

func enter():
	if enemy.patrolPoints == null or enemy.patrolPoints.get_children().size() != 2:
		print("Verifique os pontos de patrulhas")
	elif enemy.patrolPoints.get_children().size() == 2:
		points = [enemy.patrolPoints.get_children()[0].global_position.x, enemy.patrolPoints.get_children()[1].global_position.x]
		enemy.patrolPoints.queue_free()
		points.sort()

	sprite.play("default")
	$"../../TrailTimer".wait_time = 0.1
	
func physics_process(_delta : float):
	if (points[0] >= enemy.global_position.x and enemy.direction == -1) or (points[1] <= enemy.global_position.x and enemy.direction == 1):
		enemy.direction = -enemy.direction
		
	enemy.velocity.x = enemy.direction * enemy.speed
	
	if ray_cast_2d.is_colliding():
		Transitioned.emit(self, "follow")
