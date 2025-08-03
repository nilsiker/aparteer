extends Control

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color.TRANSPARENT

	var parent = get_parent() as Interactable
	if parent:
		parent.selected.connect(select)
		parent.deselected.connect(deselect)

func select() -> void:
	if tween: 
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.2)

func deselect() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.2)