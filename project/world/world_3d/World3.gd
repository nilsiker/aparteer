class_name World
extends Node3D

func _ready() -> void:
	GameChannel.readied.connect(_on_game_readied)

	WorldChannel.level_loaded.connect(_on_world_level_loaded)
	WorldChannel.level_unloaded.connect(_on_world_level_unloaded)

func _on_game_readied():
	WorldChannel.load_level("res://level/scenes/level_debug_plane.tscn")

func _on_world_level_loaded(level_path: String) -> void:
	var level: PackedScene = load(level_path)
	var node = level.instantiate()
	add_child(node)

func _on_world_level_unloaded(level_path: String) -> void:
	var node = get_children().filter(func(child: Node): child.scene_file_path == level_path).front()
	if not node:
		push_warning("no level found for ", level_path)
		return
	node.name += "_FREEING"
	node.queue_free()
