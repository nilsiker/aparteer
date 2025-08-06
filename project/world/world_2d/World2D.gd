class_name World2
extends Node2D

@export var start_scene: PackedScene

func _ready() -> void:
	GameChannel.starting.connect(_on_game_starting)
	GameChannel.quitted.connect(_on_game_quitted)

	WorldChannel.transition_started.connect(_on_world_transition_started)
	WorldChannel.level_loaded.connect(_on_world_level_loaded)
	WorldChannel.level_unloaded.connect(_on_world_level_unloaded)

func _load_level(level_path: String) -> Node:
	var level: PackedScene = load(level_path)
	if not level:
		push_error("Failed to load level at ", level_path)
		return null
	var node = level.instantiate()
	add_child(node)
	return node

func _unload_level(level_path: String) -> void:
	var node = get_children().filter(func(child: Node): return child.scene_file_path == level_path).front()
	if not node:
		push_warning("no level found for ", level_path)
		return
	NodeExt.remove(node)

func _unload_all_levels() -> void:
	NodeExt.clear_children(self)

func _transition_to_level(to_level_path: String, from_level_path: String) -> void:
	_unload_all_levels()
	var level = _load_level(to_level_path)
	WorldChannel.finish_transition(level.get_entrypoint(from_level_path))
	GameChannel.resume()
	
func _on_game_starting() -> void: _transition_to_level(start_scene.resource_path, "")

func _on_game_quitted() -> void: _unload_all_levels()

func _on_world_level_loaded(level_path: String) -> void: _load_level(level_path)

func _on_world_level_unloaded(level_path: String) -> void: _unload_level(level_path)

func _on_world_transition_started(to_level_path: String, from_level_path: String) -> void:
	GameChannel.pause()
	AppChannel.obscure(func(): _transition_to_level(to_level_path, from_level_path))
