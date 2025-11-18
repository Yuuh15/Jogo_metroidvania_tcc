extends TileMapLayer

@onready var anim = $"../../animation_players/floating_platforms"

func _ready() -> void:
	anim.play("floating_platforms")
