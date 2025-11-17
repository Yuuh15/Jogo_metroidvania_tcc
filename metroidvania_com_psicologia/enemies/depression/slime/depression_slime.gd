extends CharacterBody2D

@export var patrolPoints : Node2D
var points : Array[int]

var patrolSpeed : int = 25
var followSpeed : int = 100

var speed : int
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"../Player"
@onready var ray_cast_2d: RayCast2D = $AnimatedSprite2D/vision
var trail = preload("res://enemies/depression/slime/trail/trail.tscn")
@onready var trailPos: Marker2D = $AnimatedSprite2D/trail
@onready var walk: RayCast2D = $AnimatedSprite2D/walk
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var directionX := 1

func _ready() -> void:
	if patrolPoints == null or patrolPoints.get_children().size() != 2:
		points = [global_position.x - 50, global_position.x + 50]
	elif patrolPoints.get_children().size() == 2:
		points = [patrolPoints.get_children()[0].global_position.x, patrolPoints.get_children()[1].global_position.x]
		patrolPoints.queue_free()
		points.sort()

func _physics_process(delta: float) -> void:
	if directionX:
		sprite.scale.x = directionX
		collision_shape_2d.position.x = 3 if directionX == 1 else -3

	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = directionX * speed
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
	

func attackPlayer(area: Area2D) -> void:
	var direction = -1 if sprite.flip_h else 1
	var force = Vector2(500, 0)
	player.applyKnockback(directionX, force, 0.2)
	

func _on_hurt_box_die() -> void:
	speed = 0
	sprite.play("death")
	$AnimatedSprite2D/HitBox.queue_free()
	$StateMachineController.queue_free()
	set_collision_layer_value(4, false)
	set_collision_mask_value(1, false)
	
	sprite.animation_finished.connect(queue_free)
