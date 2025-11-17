extends TileMapLayer

@onready var anim = $"../../animation_players/floor_anim"

func _ready() -> void:
	anim.play("sinoidal_floor")
