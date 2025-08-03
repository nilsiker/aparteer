extends Node

signal transition_started(level_path: String)
signal transition_finished(entrypoint: Node)
signal level_loaded(level_path: String)
signal level_unloaded(level_path: String)

## Request to start a transition to a new level.
func transition(level_path: String) -> void:
	transition_started.emit(level_path)

## Called when the transition to a new level is finished, typically by the node handling level transitions.
func finish_transition(entrypoint: Node) -> void:
	transition_finished.emit(entrypoint)

## Request to load a level.
func load_level(level_path: String) -> void:
	level_loaded.emit(level_path)

## Request to unload a level.
func unload_level(level_path: String) -> void:
	level_unloaded.emit(level_path)
