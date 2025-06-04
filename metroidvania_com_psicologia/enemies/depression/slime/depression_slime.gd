extends CharacterBody2D

@export var patrolPoints : Node2D
@export var speed := 25
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var points : Array[int]
var direction := 1

func _ready() -> void:
	if patrolPoints == null or patrolPoints.get_children().size() != 2:
		print("Verifique os pontos de patrulhas")
	elif patrolPoints.get_children().size() == 2:
		points = [patrolPoints.get_children()[0].global_position.x, patrolPoints.get_children()[1].global_position.x]
		patrolPoints.queue_free()
		points.sort()
	
		
func _physics_process(delta: float) -> void:
	if (points[0] > global_position.x and direction == -1) or (points[1] < global_position.x and direction == 1):
		direction = -direction
		animated_sprite_2d.flip_h = true if direction == -1 else false
	velocity.x = direction * speed
	
	move_and_slide()
	

	
