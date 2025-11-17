extends Label

@export var amplitude: float = 6.0
@export var rotation_strength: float = 5.0
@export var speed: float = 0.75
@export var offset: Vector2 = Vector2(0, 0)

var time: float = 0.0
var base_position: Vector2

func _ready() -> void:
	base_position = position + offset
	position = base_position
	pivot_offset = size / 2  # funciona no Godot 4 pra Control sim!

func _process(delta: float) -> void:
	time += delta * speed

	# flutuação
	var x = cos(time * 0.5) * amplitude * 0.5
	var y = sin(time) * amplitude

	# rotação central
	rotation_degrees = sin(time * 1.5) * rotation_strength

	# aplica offsets
	position = base_position + Vector2(x, y)
