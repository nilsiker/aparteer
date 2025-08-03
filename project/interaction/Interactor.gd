class_name Interactor
extends Node2D


signal interaction_started
signal interaction_finished
signal interaction_cancelled

@export var detector: InteractableDetector

var current_interactable: Interactable

func _ready() -> void:
	detector.closest_changed.connect(_on_detector_closest_changed)
	

func has_interactable() -> bool:
	return current_interactable != null

func interact() -> bool:
	if not current_interactable: return false

	interaction_started.emit()

	match current_interactable.interaction_type:
		Interactable.InteractionType.Instant:
			interaction_finished.emit()
		Interactable.InteractionType.Duration:
			pass

	return true

func cancel_interaction() -> void:
	interaction_cancelled.emit()

func _on_detector_closest_changed(new_interactable: Interactable) -> void:
	print(new_interactable)
	current_interactable = new_interactable
