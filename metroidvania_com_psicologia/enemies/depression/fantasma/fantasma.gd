extends CharacterBody2D
class_name fantasma

@onready var projectile = preload("res://enemies/depression/fantasma/projetil_fantasma.tscn")
@onready var timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var player = null

var patrol_points: Array[Vector2] = []
var current_patrol_index := 0
var patrol_speed: float = 50.0
var reached_threshold: float = 5.0
var alive : bool = true

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	patrol_points = [
		global_position,
		global_position + Vector2(100, 0),
		global_position + Vector2(100, 0),
	]
	
	timer.wait_time = 2.0 
	timer.timeout.connect(shoot)
	timer.start()

func _physics_process(delta):
	if patrol_points.size() > 1:
		patrol_movement(delta)

func patrol_movement(delta):
	var target_position = patrol_points[current_patrol_index]
	var direction = global_position.direction_to(target_position)
	
	velocity = direction * patrol_speed
	move_and_slide()
	
	if global_position.distance_to(target_position) <= reached_threshold:
		current_patrol_index = (current_patrol_index + 1) % patrol_points.size()


func shoot():
	if alive:	
		var instance = projectile.instantiate()
		
		instance.spawnPos = global_position
		instance.target_position = player.global_position
		instance.zdex = z_index - 1
		
		get_parent().add_child(instance)

func _draw():
	if Engine.is_editor_hint() && patrol_points.size() > 1:
		for i in patrol_points.size():
			var start = patrol_points[i]
			var end = patrol_points[(i + 1) % patrol_points.size()]
			draw_line(start - global_position, end - global_position, Color(1, 0, 0), 2.0)

func _on_hurt_box_die() -> void:
	alive = false
	patrol_speed = 0
	sprite.play("dying")
	$AnimatedSprite2D/HitBox.queue_free()
	set_collision_layer_value(4, false)
	set_collision_mask_value(1, false)
	
	
	sprite.animation_finished.connect(queue_free)

func _on_hit_box_attacked() -> void:
	var direction = -1 if (player.global_position.x - global_position.x) < 0 else 1
	var force = Vector2(90, 0)
	player.applyKnockback(direction, force, 0.2)
