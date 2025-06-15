extends CharacterBody2D

@export var patrolPoints : Node2D
var points : Array[int]

@export var patrolSpeed : int = 25
@export var followSpeed : int = 100

var speed : int
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"../player"
@onready var ray_cast_2d: RayCast2D = $vision
@onready var attackArea: CollisionShape2D = $attack/CollisionShape2D
var trail = preload("res://enemies/depression/slime/trail/trail.tscn")
@onready var trailPos: Marker2D = $trail
@onready var walk: RayCast2D = $walk

var direction := 1

func _ready() -> void:
	if patrolPoints == null or patrolPoints.get_children().size() != 2:
		print("Verifique os pontos de patrulhas")
	elif patrolPoints.get_children().size() == 2:
		points = [patrolPoints.get_children()[0].global_position.x, patrolPoints.get_children()[1].global_position.x]
		patrolPoints.queue_free()
		points.sort()

func _physics_process(delta: float) -> void:
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

	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = direction * speed
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
