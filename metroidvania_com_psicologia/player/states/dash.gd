extends State

@onready var player : Player = $"../.."
@onready var duration: Timer = $Duration
@onready var cooldown: Timer = $Cooldown
@onready var dashCue: AudioStreamPlayer = $"../../Sounds/Dash"

func enter():
	player.sprite.play("dash")
	var dashDirection = -1 if player.sprite.scale.x < 0 else 1
	player.velocity.y = 0
	player.velocity.x = 450 * dashDirection
	duration.start()
	AudioPlayer.sfx_dash()

func _on_duration_timeout() -> void:
	player.velocity.x = 0
	player.dash = false
	cooldown.start()
	Transitioned.emit(self, "idle")

func _on_cooldown_timeout() -> void:
	player.dash = true
