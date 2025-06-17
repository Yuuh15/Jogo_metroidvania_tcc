extends CharacterBody2D
class_name fantasma_enemy

@onready var projectile = preload("res://projetil_fantasma.tscn")  # Make sure this is a scene
@onready var timer = $Timer  # Requires Timer node in scene

# Patrol system variables
var patrol_points: Array[Vector2] = []
var current_patrol_index := 0
var patrol_speed: float = 50.0
var reached_threshold: float = 5.0  # Distance to consider point reached

func _ready():
	# Initialize patrol points - customize these positions in your scene
	patrol_points = [
		global_position,
		global_position + Vector2(200, 0),
		global_position + Vector2(200, 100),
		global_position + Vector2(0, 100)
	]
	
	# Configure and start shooting timer
	timer.wait_time = 2.0  # Shoot every 2 seconds
	timer.timeout.connect(shoot)
	timer.start()

func _physics_process(delta):
	if patrol_points.size() > 1:  # Only patrol if we have multiple points
		patrol_movement(delta)

func patrol_movement(delta):
	var target_position = patrol_points[current_patrol_index]
	var direction = global_position.direction_to(target_position)
	
	# Move towards target point
	velocity = direction * patrol_speed
	move_and_slide()
	
	# Check if reached current target
	if global_position.distance_to(target_position) <= reached_threshold:
		# Move to next patrol point
		current_patrol_index = (current_patrol_index + 1) % patrol_points.size()

func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	instance.zdex = z_index - 1
	get_parent().add_child(instance)  # Add to parent scene

# Optional: Visualize patrol path in editor
func _draw():
	if Engine.is_editor_hint() && patrol_points.size() > 1:
		for i in patrol_points.size():
			var start = patrol_points[i]
			var end = patrol_points[(i + 1) % patrol_points.size()]
			draw_line(start - global_position, end - global_position, Color(1, 0, 0), 2.0)
