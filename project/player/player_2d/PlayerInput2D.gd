class_name PlayerInput2D
extends Node

signal input_vector_changed(input_vector: Vector2)
signal interacted


var input_vector: Vector2:
	get: return input_vector
	set(value):
		if input_vector != value:
			input_vector = value
			input_vector_changed.emit(input_vector)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo(): return
	
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if event.is_action("interact"):
		interacted.emit()