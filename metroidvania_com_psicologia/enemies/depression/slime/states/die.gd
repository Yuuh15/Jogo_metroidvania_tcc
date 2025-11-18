extends State

@export var enemy : CharacterBody2D

func enter():
	enemy.speed = 0
	enemy.sprite.play("death")
	enemy.sprite.modulate = Color.WHITE
	
	# desativa a hitbox
	enemy.hit_box.set_collision_layer_value(6, false)
	enemy.hit_box.set_collision_mask_value(9, false)
	
	# desativa a colisão
	enemy.set_collision_layer_value(4, false)
	enemy.set_collision_mask_value(1, false)
	
	enemy.sprite.animation_finished.connect(enemy.queue_free)
