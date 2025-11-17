extends VBoxContainer

@export var amplitude: float = 10.0
@export var rotation_strength: float = 5.0
@export var speed: float = 2.0
@export var scale_strength: float = 0.05  # 10%
@export var offset: Vector2 = Vector2(0, 0)

var time: float = 0.0
var base_position: Vector2

func _ready() -> void:
	base_position = position + offset
	position = base_position

	# garante rotação pelo centro
	pivot_offset = size / 2

func _process(delta: float) -> void:
	time += delta * speed

	# movimento flutuante
	var x = cos(time * 0.5) * amplitude * 0.5
	var y = sin(time) * amplitude

	# rotação
	rotation_degrees = sin(time * 1.5) * rotation_strength

	# escala pulsando (1.0 = normal)
	var s = 1.0 + sin(time * 1.2) * scale_strength
	scale = Vector2(s, s)

	# posicionamento final
	position = base_position + Vector2(x, y)
