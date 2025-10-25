extends ProgressBar

@export var player : Player

func _ready() -> void:
	# Espera o player carregar para continuar
	while !player.hurt_box:
		await get_tree().process_frame
		
	player.hurt_box.healthChanged.connect(healthUpdate)
	healthUpdate()
	
func healthUpdate():
	value = player.hurt_box.health
