extends Node

signal start_requested
signal starting
signal readied
signal saved(save: SaveFile)
signal loading
signal loaded
signal won
signal lost
signal quitted
signal paused
signal resumed

func request_start() -> void:
	start_requested.emit()

func broadcast_starting() -> void:
	starting.emit()

func broadcast_readied() -> void:
	readied.emit()

func save(save_file: SaveFile) -> void:
	saved.emit(save_file)

func load() -> void:
	loading.emit()

func broadcast_loaded() -> void:
	loaded.emit()

func win() -> void:
	won.emit()

func lose() -> void:
	lost.emit()

func quit() -> void:
	quitted.emit()

func pause() -> void:
	paused.emit()

func resume() -> void:
	resumed.emit()
