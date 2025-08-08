class_name PlayerSprite
extends Sprite2D

@onready var label: Label = %AnimLabel
@onready var anim: AnimationPlayer = $AnimationPlayer

func idle() -> void:
	anim.play("idle")

func walk() -> void:
	anim.play("walk")

func interact() -> void:
	#anim.play("interact")
	label.text = "interact"

func face(vector: Vector2) -> void:
	if vector == Vector2.ZERO: return

	flip_h = vector.x < 0
