class_name InputManager
extends Node

func _ready() -> void:
	OptionsChannel.input_action_changed.connect(_on_input_action_changed)

	init_actions()

func init_actions() -> void:
	var actions = InputMap.get_actions()
	var configured_actions: Dictionary = InputConfig.get_input_map()

	for action in actions:
		print("initializing action: ", action)
		if(action in configured_actions):
			var event = configured_actions[action] as InputEvent
			print("Action has configured event: ", event.as_text())
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
		else:
			print("Action has no configured event, using default.")

func _on_input_action_changed(changed_action: String, new_event: InputEvent) -> void:
	if not InputMap.has_action(changed_action):  
		push_error("Input action does not exist: " + changed_action)
		return

	InputConfig.set_action_key(changed_action, new_event)
