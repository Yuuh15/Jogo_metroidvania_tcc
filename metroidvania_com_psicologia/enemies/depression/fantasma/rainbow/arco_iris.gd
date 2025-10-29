extends CharacterBody2D

class_name arcoIris_enemy

@onready var enemy_sprite = $AnimatedSprite2D
@onready var detection_area = $DetectionArea
@onready var direction_timer = $DirectionTimer
@onready var laser_raycast = $RayCast2D
@onready var laser_cooldown = $LaserCooldown
@onready var laser_duration = $LaserDuration
@onready var laser_sprite = $LaserSprite
@onready var laser_hitbox = $LaserHitbox

var is_chase: bool = false
var is_roaming: bool = true
var can_fire_laser: bool = true
var dir: Vector2 = Vector2.ZERO
var player_ref: Node2D = null

func _ready():
	add_to_group("enemies")
	
	direction_timer.timeout.connect(_on_DirectionTimer_timeout)
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	detection_area.body_exited.connect(_on_detection_area_body_exited)
	laser_cooldown.timeout.connect(_on_LaserCooldown_timeout)
	laser_duration.timeout.connect(_on_LaserDuration_timeout)
	
	_on_DirectionTimer_timeout()

func _physics_process(delta):
	if can_fire_laser and laser_raycast.is_colliding():
		var collider = laser_raycast.get_collider()
		if collider is Player:
			fire_laser()
			velocity = Vector2.ZERO
			move_and_slide()
			return

	if is_chase and is_instance_valid(player_ref):
		dir = global_position.direction_to(player_ref.global_position)
		velocity = dir * 10
	elif is_roaming:
		velocity = velocity.move_toward(dir * 10, 10 * delta)
	else:
		velocity = Vector2.ZERO
	move_and_slide()


func fire_laser():
	can_fire_laser = false
	var target_pos = laser_raycast.get_collision_point()
	
	var distance = global_position.distance_to(target_pos)
	var sprite_height = laser_sprite.texture.get_height()
	var scale_y = distance / sprite_height
	
	var halfway_point = global_position.lerp(target_pos, 0.5)
	laser_sprite.global_position = halfway_point
	laser_hitbox.global_position = halfway_point
	
	laser_sprite.scale.y = scale_y
	laser_hitbox.scale.y = scale_y
	
	laser_sprite.visible = true
	laser_hitbox.get_node("CollisionShape2D").set_deferred("disabled", false)
	
	laser_duration.start()
	laser_cooldown.start()

func _on_LaserDuration_timeout():
	laser_sprite.visible = false
	laser_hitbox.get_node("CollisionShape2D").set_deferred("disabled", true)

func _on_LaserCooldown_timeout():
	can_fire_laser = true

func _on_LaserHitbox_body_entered(body):
	return
	
func _on_DirectionTimer_timeout():
	if !is_chase and is_roaming:
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.ZERO])
	direction_timer.wait_time = choose([1.2, 1.6, 2])
	direction_timer.start()

func choose(array):
	array.shuffle()
	return array.front()

func _on_detection_area_body_entered(body):
	if body is Player:
		player_ref = body
		enemy_sprite.play("attack")
		is_chase = true
		is_roaming = false
		

func _on_detection_area_body_exited(body):
	if body == player_ref:
		player_ref = null
		is_chase = false
		is_roaming = true
