class_name HitBox
extends Area2D

@export var damage : int = 0
@export var enemy : bool = true

signal attacked

func _ready() -> void:
	if enemy:
		add_to_group("damage", true)
	
	area_entered.connect(attack)
	
func attack(hurtBox : HurtBox):
	attacked.emit()
	hurtBox.health -= damage
	hurtBox.takeDamage()
