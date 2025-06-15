extends CharacterBody2D

@export var patrolPoints : Node2D
@export var speed := 25
@export var followSpeed := 100
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var player : CharacterBody2D
@onready var ray_cast_2d: RayCast2D = $vision
@onready var attackArea: CollisionShape2D = $attack/CollisionShape2D
var trail = preload("res://enemies/depression/slime/trail/trail.tscn")
@onready var trailPos: Marker2D = $trail
@onready var walk: RayCast2D = $walk

var direction := 1

func _process(delta: float) -> void:
	if direction == 1:
		sprite.flip_h = false
		ray_cast_2d.target_position.x = 80
		attackArea.position.x = 9
		trailPos.position.x = -14
		walk.position.x = 17
	else:
		sprite.flip_h = true
		ray_cast_2d.target_position.x = -80
		attackArea.position.x = -9
		trailPos.position.x = 14
		walk.position.x = -17
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _on_trail_timer_timeout() -> void:
	if is_on_floor():
		var newTrail = trail.instantiate() as Node2D
		newTrail.global_position = trailPos.global_position
		get_parent().add_child(newTrail)
		
func canWalk() -> bool:
	if walk.is_colliding():
		return true
	return false
