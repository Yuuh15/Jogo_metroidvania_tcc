class_name Player
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt: AudioStreamPlayer = $Hurt
@onready var jump: AudioStreamPlayer = $Jump

var directionX : float
var directionY : float

# variáveis de pulo.
var maxAirJumps = 0
var airJumps = 0

# velocidade do jogador no estado de running
const SPEED = 150

# items que o jogador tem.
var dash = false
var stomp = false
var timeWarp = false

# vida
signal healthChanged()
@export var health : int = 100
var damageAreas

var knockback : Vector2
var knockbackDuration : float

func _ready() -> void:
	#loadSave()
	damageAreas = get_tree().get_nodes_in_group("damage")
	airJumps = maxAirJumps
	
	if damageAreas.size() != 0:
		for area in damageAreas:
			area.body_entered.connect(takeDamage.bind(area))

func _process(delta: float) -> void:
	if directionX > 0:
		sprite.flip_h = false
	elif directionX < 0:
		sprite.flip_h = true
	
func _physics_process(delta: float) -> void:
	directionX = Input.get_axis("move_left", "move_right")
	directionY = Input.get_axis("move_up", "move_down")
	
	if Input.is_action_just_pressed("time_warp") && timeWarp:
		Engine.time_scale = 0.5
		$TimeWarpDuration.start()
		
	# desbloqueia todas as habilidades
	if Input.is_action_just_pressed("DEV_TOOL"):
		dash = true
		stomp = true
		timeWarp = true
		maxAirJumps = 1
	
	# aplica knockback
	if knockbackDuration > 0:
		velocity = knockback
		knockbackDuration -= delta
		if 0 > knockbackDuration:
			knockback = Vector2.ZERO
	
	move_and_slide()
	
func applyGravity(delta : float):
	if not is_on_floor():
		velocity += get_gravity() * delta

func _on_debug_timeout() -> void:
	print("Dash:", dash)

func _on_time_warp_duration_timeout() -> void:
	Engine.time_scale = 1
	
func takeDamage(body : Node2D, area : Area2D):
	if body == self:
		health -= area.damage
		healthChanged.emit()
		hurt.play()
		if health <= 0:
			get_tree().change_scene_to_file("res://gui/menu/main_menu.tscn")

func applyKnockback(direction : int, force : Vector2, duration : float):
	knockbackDuration = duration
	knockback = direction * force
