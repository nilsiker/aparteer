class_name Interactor
extends Node2D


signal interaction_started
signal interaction_finished
signal interaction_cancelled


var current_interactable: Interactable

func is_missing_interactable() -> bool:
	return current_interactable == null

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