extends State

@onready var player: Player = $"../.."

func enter():
	player.velocity = player.get_gravity() * 0.75

func physics_process(delta: float) -> void:
	if player.is_on_floor():
		Transitioned.emit(self, "idle")

func _on_cooldown_timeout() -> void:
	player.stomp = true
