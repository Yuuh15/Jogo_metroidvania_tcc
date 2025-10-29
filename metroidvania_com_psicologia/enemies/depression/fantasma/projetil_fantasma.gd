extends CharacterBody2D

@export var speed = 300
@export var max_lifetime = 2.0

var target_position: Vector2

var direction: Vector2 = Vector2.ZERO
var spawnPos: Vector2
var zdex: int = 2
var has_hit = false
var lifetime = 0.0

@onready var hitbox = $Area2D
@onready var collision_shape = $Area2D/CollisionShape2D
@onready var sprite = $AnimatedSprite2D

func _ready():
	global_position = spawnPos
	z_index = zdex
	
	if not target_position.is_zero_approx():
		direction = (target_position - global_position).normalized()
	else:
		direction = Vector2.UP.rotated(rotation)

	rotation = direction.angle()
	
	collision_shape.set_deferred("disabled", true)
	await get_tree().create_timer(0.1).timeout
	collision_shape.set_deferred("disabled", false)

func _physics_process(delta):
	if has_hit:
		return
	
	lifetime += delta
	if lifetime >= max_lifetime:
		queue_free()
		return
	
	velocity = direction * speed
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if has_hit:
		return
	
	if body.is_in_group("enemies") or body.is_in_group("projectiles"):
		return
	
	if body.is_in_group("player"):
		has_hit = true
		
		var direction_vector = body.global_position - self.global_position
		var knock_direction_int = sign(direction_vector.x)
		
		if knock_direction_int == 0:
			knock_direction_int = 1
			
		var force = Vector2(175, 0)
		var duration = 0.2
		
		body.applyKnockback(knock_direction_int, force, duration)
		sprite.play("exploding")
		queue_free()
	
	else:
		has_hit = true
		sprite.play("exploding")
		queue_free()

func _on_life_timeout() -> void:
	sprite.play("exploding")
	queue_free()
