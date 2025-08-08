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

func vertical() -> float:
	return input_vector.y

func horizontal() -> float:
	return input_vector.x

func _process(_delta: float) -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo(): return
	
	if event.is_action_pressed("interact"):
		interacted.emit()
