extends Node

signal started
signal saved(save: SaveFile)
signal loaded
signal won
signal lost
signal quitted

func start() -> void:
	started.emit()

func save(save_file: SaveFile) -> void:
	saved.emit(save_file)

func load() -> void:
	loaded.emit()

func win() -> void:
	won.emit()

func lose() -> void:
	lost.emit()

func quit() -> void:
	quitted.emit()
