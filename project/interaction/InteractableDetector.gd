class_name InteractableDetector
extends Area2D

signal in_range_changed(interactables: Array[Interactable])
signal closest_changed(interactable: Interactable)

var in_range_interactables: Array[Interactable] = []
var closest_interactable: Interactable = null

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	in_range_changed.connect(_on_in_range_changed)

func _try_add_interactable(node: Node) -> void:
	var interactables = node.find_children("*", "Interactable")
	if interactables.is_empty(): return
	var interactable = interactables.front() as Interactable
	if interactable:
		in_range_interactables.append(interactable)
		in_range_changed.emit(in_range_interactables)

func _try_remove_interactable(node: Node) -> void:
	var interactables = node.find_children("*", "Interactable")
	if interactables.is_empty(): return
	var interactable = interactables.front() as Interactable
	if interactable in in_range_interactables:
		in_range_interactables.erase(interactable)
		in_range_changed.emit(in_range_interactables)

func _determine_closest(interactables: Array[Interactable]) -> void:
	if interactables.size() == 0:
		closest_interactable = null
		closest_changed.emit(closest_interactable)
		return

	closest_interactable = interactables[0]

	for interactable in interactables:
		var closest_distance = global_position.distance_to(closest_interactable.get_global_pos())
		var interactable_distance = global_position.distance_to(interactable.get_global_pos())
		if interactable_distance < closest_distance:
			closest_interactable = interactable
	
	closest_changed.emit(closest_interactable)


func _on_area_entered(area: Area2D) -> void: _try_add_interactable(area)

func _on_area_exited(area: Area2D) -> void: _try_remove_interactable(area)

func _on_body_entered(body: Node) -> void: _try_add_interactable(body)

func _on_body_exited(body: Node) -> void: _try_remove_interactable(body)
	
func _on_in_range_changed(interactables: Array[Interactable]) -> void: _determine_closest(interactables)
