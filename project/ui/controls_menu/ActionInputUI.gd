class_name ActionInputUI
extends HBoxContainer

@export var action: String

@onready var label: Label = %Label
@onready var button: Button = %Button
@onready var input_blocker: Control = %InputBlocker

enum Status {
	IDLE,
	LISTENING
}

var status = Status.IDLE

var revert_event_text = ""

func _ready() -> void:
	OptionsChannel.input_action_changed.connect(_on_input_action_changed)
	button.pressed.connect(_on_button_pressed)

	label.text = action
	button.text = InputManager.get_input_event(action).as_text().split(" (")[0]


func focus() -> void:
	if button:
		button.grab_focus()

func _on_input_action_changed(changed_action: String, new_event: InputEvent) -> void:
	print(changed_action, " changed to ", new_event)
	if self.action != changed_action: return
	button.text = new_event.as_text().split(" (")[0]

func _start_listening() -> void:
	if status != Status.IDLE: return
	status = Status.LISTENING
	button.disabled = true

	revert_event_text = button.text
	button.text = "Listening..."
	input_blocker.visible = true

	get_viewport().set_input_as_handled()

func _stop_listening() -> void:
	if status != Status.LISTENING: return
	status = Status.IDLE
	button.disabled = false

	input_blocker.visible = false

	get_viewport().set_input_as_handled()

func _on_button_pressed() -> void:
	_start_listening()

func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventKey and event is not InputEventMouseButton: return
	if event.is_echo(): return
	if event.is_released(): return

	match status:
		Status.IDLE: return
		Status.LISTENING:
			_on_input_when_listening(event)
	

func _on_input_when_listening(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		button.text = revert_event_text
		_stop_listening()
	else:
		OptionsChannel.change_input_action(action, event)
		_stop_listening()
