extends Label

var base_y := 0.0
var speed := 2.0
var amplitude := 12.0

func _ready():
	base_y = position.y

func _process(delta):
	position.y = base_y + sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude
