class_name Level
extends Node2D

@onready var transition_areas: Node = $TransitionAreas

func get_entrypoint(from_level_path: String) -> Node2D:
	var from_area = _get_area_arriving_from(from_level_path)
	if from_area: return from_area.find_child("Entrypoint")
	else: return null

func _get_area_arriving_from(from_path: String) -> Node2D:
	var areas = transition_areas.get_children()
	var filteredAreas = areas.filter(func(area): return area.from_path == from_path)
	return areas.front()
	
