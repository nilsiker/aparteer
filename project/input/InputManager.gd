class_name InputManager
extends Node

@export var ignore_prefixes: PackedStringArray = PackedStringArray(["ui", "game", "editor"])

func _ready() -> void:
	OptionsChannel.input_defaults_restored.connect(_on_input_defaults_restored)

	init_actions()


func init_actions() -> void:
	var actions = InputMap.get_actions()
	var configured_actions: Dictionary = InputConfig.get_input_map()

	for action in actions:
		if(action in configured_actions):
			var events = configured_actions[action] as Array[InputEvent]
			InputMap.action_erase_events(action)
			for event in events:
				InputMap.action_add_event(action, event)

func _on_input_defaults_restored() -> void:
	InputMap.load_from_project_settings()
	var actions = InputMap.get_actions()
	for action in actions:
		if action.split("_")[0] in ignore_prefixes: continue
		var events := InputMap.action_get_events(action)

		if events.is_empty(): continue

		var first_event = events.front() as InputEvent
		OptionsChannel.change_input_action(action, first_event)
	InputConfig.delete()

static func get_input_event(action: String) -> InputEvent:
	var overridden = InputConfig.get_action(action)
	if overridden:
		return overridden as InputEvent
	else:
		return InputMap.action_get_events(action)[0]
