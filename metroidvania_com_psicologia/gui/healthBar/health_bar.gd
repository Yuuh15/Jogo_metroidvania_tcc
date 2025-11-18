extends ProgressBar

@export var player: Player
@onready var anim = $"../../animation_players/health_bar"

func _ready() -> void:
	# Espera o player carregar para continuar
	while !player.hurt_box:
		await get_tree().process_frame
		
	player.hurt_box.healthChanged.connect(healthUpdate)
	player.hurt_box.heal.connect(healthUpdate)
	healthUpdate()
	
func healthUpdate():
	value = player.hurt_box.health
	anim.play("damage")
