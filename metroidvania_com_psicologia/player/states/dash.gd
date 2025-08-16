extends State

@onready var player : Player = $"../.."
@onready var duration: Timer = $Duration
@onready var cooldown: Timer = $Cooldown

func enter():
	var dashDirection = -1 if player.sprite.flip_h else 1
	player.velocity.y = 0
	player.velocity.x = 450 * dashDirection
	
	duration.start()

func _on_duration_timeout() -> void:
	player.velocity.x = 0
	player.dash = false
	cooldown.start()
	Transitioned.emit(self, "idle")

func _on_cooldown_timeout() -> void:
	player.dash = true
