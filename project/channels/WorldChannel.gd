extends Node

signal level_loaded(level_path: String)
signal level_unloaded(level_path: String)

func load_level(level_path: String) -> void:
	level_loaded.emit(level_path)

func unload_level(level_path: String) -> void:
	level_unloaded.emit(level_path)
