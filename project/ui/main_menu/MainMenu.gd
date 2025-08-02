class_name MainMenu
extends Control

@onready var play_button: Button = %PlayButton
@onready var load_button: Button = %LoadButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	GameChannel.started.connect(_on_game_started)
	GameChannel.quitted.connect(_on_game_quitted)

	play_button.pressed.connect(_on_play_button_pressed)
	load_button.pressed.connect(_on_load_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

	play_button.grab_focus()

func _on_play_button_pressed() -> void:
	AppChannel.obscure(func(): GameChannel.start())

func _on_load_button_pressed() -> void:
	AppChannel.obscure(GameChannel.load)

func _on_options_button_pressed() -> void:
	OptionsChannel.open_ui()

func _on_quit_button_pressed() -> void:
	AppChannel.obscure(AppChannel.quit)

func _on_game_started() -> void:
	visible = false


func _on_game_quitted() -> void:
	visible = true
	play_button.grab_focus()

func _on_options_menu_closed() -> void:
	options_button.grab_focus()

func _on_controls_menu_closed() -> void:
	options_button.grab_focus()
