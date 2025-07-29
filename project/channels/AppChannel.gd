extends Node

signal obscured(callback: Callable)
signal revealed
signal quitted

func obscure(callback: Callable) -> void:
	obscured.emit(callback)

func reveal() -> void:
	revealed.emit()

func quit() -> void:
	quitted.emit()