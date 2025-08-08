@tool
class_name Pickup
extends InteractableArea

@export var item: ItemResource

func interact() -> void:
	on_picked_up()
	
func on_picked_up() -> void:
	NodeExt.remove(self)
