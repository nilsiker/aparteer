extends PanelContainer

signal closed

@export var ignore_prefixes: PackedStringArray = []

@onready var action_grid: GridContainer = %ActionGrid
@onready var back_to_options_button: Button = %BackToOptionsButton
@onready var close_button: Button = %CloseButton


func _ready() -> void:
	OptionsChannel.controls_ui_opened.connect(_on_controls_ui_opened)

	close_button.pressed.connect(_on_close_button_pressed)
	back_to_options_button.pressed.connect(_on_back_to_options_button_pressed)
	
	init_from_actions()

func init_from_actions() -> void:
	

	for action in InputMap.get_actions():
		var prefix = action.split("_")[0]
		if ignore_prefixes.has(prefix): continue
		print(action)


func _on_controls_ui_opened() -> void:
	visible = true
	action_grid.get_child(0).focus()

func _on_controls_button_pressed() -> void:
	visible = false

func _on_close_button_pressed() -> void:
	visible = false
	closed.emit()

func _on_back_to_options_button_pressed() -> void:
	visible = false
	OptionsChannel.open_ui()
