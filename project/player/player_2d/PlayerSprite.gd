class_name PlayerSprite
extends Sprite2D

@onready var label: Label = %AnimLabel

var _side: String = "r"
var _action: String = "idle"

const SIDE_L = "l"
const SIDE_R = "r"
const SIDE_F = "f"
const SIDE_B = "b"

func idle() -> void:
	_action = "idle"
	_update_animation()

func walk() -> void:
	_action = "walk"
	_update_animation()

func face(vector: Vector2) -> void:
	if vector == Vector2.ZERO:return

	if vector.y < 0:
		flip_h = false
		_side = SIDE_F
	elif vector.y > 0:
		flip_h = false
		_side = SIDE_B
	elif vector.x < 0:
		flip_h = true
		_side = "s"
	elif vector.x > 0:
		flip_h = false
		_side = "s"
	_update_animation()
		
func _update_animation() -> void:
	# $AnimationPlayer.play("{0}_{1}".format(_side, _action))
	label.text = "{0}_{1}".format([_side, _action])
