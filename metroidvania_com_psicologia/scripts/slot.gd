extends Control

@onready var slot: Control = $"."

var splitMode = false

func _get_drag_data(at_position: Vector2) -> Variant:
	var data := {
	"sprite" : $sprite.texture,
	"amount" : $amount.text,
	"backup" : self
	}

	var preview = self.duplicate()
	preview.get_node("background").hide()
	preview.get_node("amount").hide()
	
	split_items()
	set_empty_slot()
	set_drag_preview(preview)
	
	print(splitMode)
	return data


func set_empty_slot() -> void:
	$sprite.texture = null
	$amount.text = ""

func split_items() -> void:
	if Input.is_action_pressed("split_items", true):
		splitMode = true
	else:
		splitMode = false

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if $sprite.texture == data.sprite and splitMode == false:
		var dropItem = int($amount.text)
		dropItem += int(data.amount)
		$amount.text = str(dropItem)
	else:
		if $sprite.texture == data.sprite and splitMode == true:
			var dropItem = int($amount.text)
			dropItem += int(data.amount)
			$amount.text = str(dropItem/2)
		data.backup.get_node("sprite").texture = $sprite.texture
		data.backup.get_node("amount").text = $amount.text
	
		$sprite.texture = data["sprite"]
		$amount.text = data["amount"]
