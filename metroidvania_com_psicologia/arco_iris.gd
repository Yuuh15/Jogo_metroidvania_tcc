extends CharacterBody2D

class_name arcoIris_enemy

const SPEED = 10
var is_chase: bool = false

var health = 20
var health_max = 20
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 20
var dealing_damage: bool = false

var dir: Vector2 = Vector2.ZERO  # Should be Vector2, not float
var knockback_force = 200
var is_roaming: bool = true
var player_ref: Node2D = null  # Missing reference to player

# Add these signals to connect in the editor
signal player_detected
signal player_lost

func _ready():
	
	add_to_group("player")
	collision_layer = 1
	# Initialize the timer
	$DirectionTimer.wait_time = choose([1.5, 2.0, 2.5])
	$DirectionTimer.start()
	
	# Setup detection area (must exist in your scene)
	$DetectionArea.body_entered.connect(_on_detection_area_body_entered)
	$DetectionArea.body_exited.connect(_on_detection_area_body_exited)

func _physics_process(delta):
	if dead: 
		velocity = Vector2.ZERO
		return
	
	move(delta)
	move_and_slide()

func move(delta):
	if is_chase && player_ref:
		# CHASE LOGIC: Move toward player
		dir = global_position.direction_to(player_ref.global_position)
		velocity = dir * SPEED
	elif is_roaming:
		# ROAMING LOGIC: Move in random direction
		velocity = velocity.move_toward(dir * SPEED, SPEED * delta)
	else:
		velocity = Vector2.ZERO

func _on_direction_timer_timeout() -> void:
	if !is_chase && is_roaming:
		# Only change direction when roaming
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
	$DirectionTimer.wait_time = choose([0.5, 1.0, 1.2])
	$DirectionTimer.start()

func choose(array):
	array.shuffle()
	return array.front()

# Player detection functions
func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):  # Make sure player is in "player" group
		player_ref = body
		is_chase = true
		is_roaming = false
		player_detected.emit()

func _on_detection_area_body_exited(body):
	if body == player_ref:
		player_ref = null
		is_chase = false
		is_roaming = true
		player_lost.emit()
