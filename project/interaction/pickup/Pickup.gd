class_name Pickup
extends Interactable

@export var id: String

func interact() -> void:
	print("Pickup interact called on ", id)