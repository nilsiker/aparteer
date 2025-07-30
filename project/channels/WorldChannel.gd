extends Node

signal transition_started(level_path: String)
signal transition_finished(entrypoint: Node)
signal level_loaded(level_path: String)
signal level_unloaded(level_path: String)

func transition(level_path: String) -> void:
	transition_started.emit(level_path)
	
func finish_transition(entrypoint: Node) -> void:
	transition_finished.emit(entrypoint)

func load_level(level_path: String) -> void:
	level_loaded.emit(level_path)

func unload_level(level_path: String) -> void:
	level_unloaded.emit(level_path)
