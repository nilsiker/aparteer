class_name World
extends Node3D

func _ready() -> void:
	WorldChannel.level_loaded.connect(_on_world_level_loaded)
	WorldChannel.level_unloaded.connect(_on_world_level_unloaded)

func _on_world_level_loaded(level_path: String) -> void:
	print("World level loaded: ", level_path)

func _on_world_level_unloaded(level_path: String) -> void:
	print("World level unloaded: ", level_path)
