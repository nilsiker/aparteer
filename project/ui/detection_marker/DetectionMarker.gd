extends Control

var tween: Tween
var _initial_scale

var detected: bool = false
var selected: bool = false

func _ready() -> void:
	_initial_scale = scale
	modulate = Color.TRANSPARENT

	var parent = get_parent()
	if  parent is InteractableArea2D:
		parent.detected.connect(detect)
		parent.undetected.connect(undetect)
		parent.selected.connect(select)
		parent.deselected.connect(deselect)

func _update_icon() -> void:
	if tween and tween.is_running(): 
		tween.kill()
	tween = create_tween()
	tween.set_parallel(true)
	match [detected, selected]:
		[false, false]:
			tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.2)
		[true, false]:
			tween.tween_property(self, "modulate", Color.WHITE / 1.5, 0.2)
			tween.tween_property(self, "scale", _initial_scale, 0.2)
		[false, true], [true, true]:
			tween.tween_property(self, "modulate", Color.WHITE, 0.2)
			tween.tween_property(self, "scale", _initial_scale * 1.5, 0.2)

func detect() -> void: 
	print("delected")
	detected = true
	_update_icon()

func undetect() -> void: 
	detected = false
	_update_icon()

func select() -> void: 
	print("selected")
	selected = true
	_update_icon()

func deselect() -> void: 
	selected = false
	_update_icon()
