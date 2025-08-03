class_name InteractableDetector
extends Area2D

signal in_range_changed(interactables: Array[Interactable])

var in_range_interactables: Array[Interactable] = []

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _try_add_interactable(node: Node) -> void:
	var interactables = node.find_children("*", "Interactable")
	if interactables.is_empty(): return
	var interactable = interactables.front() as Interactable
	if interactable:
		in_range_interactables.append(interactable)
		interactable.on_detected()
		in_range_changed.emit(in_range_interactables)

func _try_remove_interactable(node: Node) -> void:
	var interactables = node.find_children("*", "Interactable")
	if interactables.is_empty(): return
	var interactable = interactables.front() as Interactable
	if interactable in in_range_interactables:
		in_range_interactables.erase(interactable)
		interactable.on_undetected()
		in_range_changed.emit(in_range_interactables)


func _on_area_entered(area: Area2D) -> void: _try_add_interactable(area)

func _on_area_exited(area: Area2D) -> void: _try_remove_interactable(area)

func _on_body_entered(body: Node) -> void: _try_add_interactable(body)

func _on_body_exited(body: Node) -> void: _try_remove_interactable(body)
