class_name Interactable
extends Node

enum InteractionType {
	Instant,
	Duration,
}

@export var interaction_type: InteractionType = InteractionType.Instant