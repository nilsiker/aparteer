class_name MainMenu
extends Control

@onready var play_button: Button = %PlayButton
@onready var save_button: Button = %SaveButton
@onready var load_button: Button = %LoadButton
@onready var quit_button: Button = %QuitButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameChannel.started.connect(_on_game_started)

	play_button.pressed.connect(_on_play_button_pressed)
	save_button.pressed.connect(_on_save_button_pressed)
	load_button.pressed.connect(_on_load_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func _on_play_button_pressed() -> void:
	AppChannel.obscure(func(): GameChannel.start())

func _on_save_button_pressed() -> void:
	GameChannel.save(SaveManager.SAVE_FILE)

func _on_load_button_pressed() -> void:
	GameChannel.load()

func _on_quit_button_pressed() -> void:
	AppChannel.quit()

func _on_game_started() -> void:
	visible = false
