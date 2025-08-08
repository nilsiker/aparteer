class_name Interactor
extends Node2D


signal interaction_started
signal interaction_finished
signal interaction_cancelled

@export var picker: InteractableSelector

var current_interactable: InteractableArea2D

func _ready() -> void:
	picker.selected.connect(_on_picker_selected)

func has_interactable() -> bool:
	return current_interactable != null

func interact() -> bool:
	if not current_interactable: return false

	interaction_started.emit()

	match current_interactable.interaction_type:
		InteractableArea2D.InteractionType.Instant:
			current_interactable.interact()
			interaction_finished.emit()
		InteractableArea2D.InteractionType.Duration:
			pass

	return true

func cancel_interaction() -> void:
	interaction_cancelled.emit()

func _on_picker_selected(previous: InteractableArea2D, new: InteractableArea2D) -> void:
	if previous: previous.on_deselected()
	if new: new.on_selected()
	current_interactable = new
