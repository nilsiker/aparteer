class_name Level
extends Node2D

@onready var transition_areas: Node = $TransitionAreas

func get_entrypoint(from_level_path: String) -> Node2D:
	var areas = transition_areas.get_children().filter(func(area): return area.from_path == from_level_path)
	
	if (areas.is_empty()): return null
	else: return areas.pop_back().find_child("Entrypoint")
