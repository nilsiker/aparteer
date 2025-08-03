class_name Interactable
extends Node

enum InteractionType {
	Instant,
	Duration,
}

@export var interaction_type: InteractionType = InteractionType.Instant

func interact() -> void:
	push_warning("Interactable.interact() called without implementation in", self, ". This should be overridden in subclasses.")
	pass

func get_global_pos() -> Vector2:
	return get_parent().global_position