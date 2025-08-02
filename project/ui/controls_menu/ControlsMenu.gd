extends PanelContainer

signal closed

@export var ignore_prefixes: PackedStringArray
@export var action_input_ui_scene: PackedScene

@onready var action_grid: GridContainer = %ActionGrid
@onready var revert_to_defaults_button: Button = %RevertToDefaultsButton
@onready var back_to_options_button: Button = %BackToOptionsButton
@onready var close_button: Button = %CloseButton


func _ready() -> void:
	OptionsChannel.controls_ui_opened.connect(_on_controls_ui_opened)

	close_button.pressed.connect(_on_close_button_pressed)
	back_to_options_button.pressed.connect(_on_back_to_options_button_pressed)
	revert_to_defaults_button.pressed.connect(_on_revert_to_defaults_button_pressed)

	_init_from_actions()

func _init_from_actions() -> void:
	NodeExt.clear_children(action_grid)
	for action in InputMap.get_actions():
		var prefix = action.split("_")[0]
		if ignore_prefixes.has(prefix): continue
		_add_action_input_ui(action)

func _add_action_input_ui(action: String) -> void:
	var action_input_ui = action_input_ui_scene.instantiate() as ActionInputUI
	action_input_ui.action = action
	action_grid.add_child(action_input_ui)

func _on_controls_ui_opened() -> void:
	visible = true
	action_grid.get_child(0).focus()

func _on_revert_to_defaults_button_pressed() -> void:
	OptionsChannel.restore_input_defaults()

func _on_controls_button_pressed() -> void:
	visible = false

func _on_close_button_pressed() -> void:
	visible = false
	closed.emit()

func _on_back_to_options_button_pressed() -> void:
	visible = false
	OptionsChannel.open_ui()
