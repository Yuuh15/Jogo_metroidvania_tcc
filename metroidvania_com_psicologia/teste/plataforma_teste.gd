extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var shard_emitter: ShardEmitter = $Sprite2D/ShardEmitter

func _on_area_2d_body_entered(body: Node2D) -> void:
	set_collision_layer_value(2, false)
	shard_emitter.config()
	shard_emitter.shatter()
	
