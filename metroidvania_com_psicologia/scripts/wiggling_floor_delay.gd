extends TileMapLayer

@onready var anim = $"../../animation_players/floor_anim_delay"

func _ready() -> void:
	await get_tree().create_timer(0.5)
	anim.play("sinoidal_floor_delay", -1, 0.75)
