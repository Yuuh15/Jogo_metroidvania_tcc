extends CharacterBody2D

@export var speed = 300  # Increased for better visibility
@export var max_lifetime = 3.0  # Maximum time before auto-destruction

var direction: Vector2 = Vector2.UP  # Default direction
var spawnPos: Vector2
var spawnRot: float
var zdex: int
var has_hit = false  # Prevent multiple hits
var lifetime = 0.0

# Node references
@onready var hitbox = $Area2D
@onready var collision_shape = $Area2D/CollisionShape2D
@onready var sprite = $Sprite2D  # Add a Sprite2D for visual feedback

func _ready():
	global_position = spawnPos
	global_rotation = direction.angle()  # Set rotation based on direction
	z_index = zdex
	
	# Disable collision briefly to avoid self-collision
	collision_shape.set_deferred("disabled", true)
	await get_tree().create_timer(0.1).timeout
	collision_shape.set_deferred("disabled", false)

func _physics_process(delta):
	if has_hit:
		return
	
	# Update lifetime
	lifetime += delta
	if lifetime >= max_lifetime:
		queue_free()
		return
	
	# Movement
	velocity = direction * speed
	move_and_slide()
	

# Improved collision handling
func _on_area_2d_body_entered(body: Node2D) -> void:
	if has_hit:
		return
	
	# Ignore certain bodies (like the enemy that shot this)
	if body.is_in_group("enemies") || body.is_in_group("projectiles"):
		return
	
	# Handle player hit
	if body.is_in_group("player") && body.has_method("take_damage"):
		body.take_damage(10)  # Adjust damage as needed
		has_hit = true
		queue_free()
	
	# Handle wall/obstacle hit
	elif body.is_in_group("world"):
		has_hit = true
		queue_free()



# Backup lifetime timer (optional)
func _on_life_timeout() -> void:
	queue_free()
