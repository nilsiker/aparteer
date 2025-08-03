class_name InteractableSelector
extends Area2D

signal selected(previous: Interactable, new: Interactable)

@export var direction: Vector2 = Vector2.RIGHT

var _selected: Interactable = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var nodes = get_overlapping_bodies()
	var areas = get_overlapping_areas()
	nodes.append_array(areas)

	if nodes.is_empty(): _clear_selection()

	var interactables = []
	for node in nodes:
		var children = node.get_children().filter(func(child): return child is Interactable)
		interactables.append_array(children)

	_select_closest(interactables)


func _select_closest(interactables: Array) -> void:
	var current = _selected
	var new_closest: Interactable = null if interactables.is_empty() else interactables.front()
	for candidate in interactables:
		var closest_distance = global_position.distance_to(new_closest.get_global_pos())
		var candidate_distance = global_position.distance_to(candidate.get_global_pos())
		if candidate_distance < closest_distance:
			new_closest = candidate

	if new_closest != current:
		_selected = new_closest
		selected.emit(current, _selected)

func _clear_selection() -> void:
	if _selected:
		var previous = _selected
		_selected = null
		selected.emit(previous, null)
