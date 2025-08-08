class_name InteractableDetector
extends Area2D

signal in_range_changed(interactables: Array[Node])

var in_range_interactables: Array[Node] = []

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _try_add_interactable(node: Node) -> void:
	if node.has_method("interact"):
		in_range_interactables.append(node)
		node.on_detected()
		in_range_changed.emit(in_range_interactables)

func _try_remove_interactable(node: Node) -> void:
	if not node.has_method("interact"): return
	
	in_range_interactables.erase(node)
	node.on_undetected()
	in_range_changed.emit(in_range_interactables)


func _on_area_entered(area: Area2D) -> void: _try_add_interactable(area)

func _on_area_exited(area: Area2D) -> void: _try_remove_interactable(area)

func _on_body_entered(body: Node) -> void: _try_add_interactable(body)

func _on_body_exited(body: Node) -> void: _try_remove_interactable(body)
