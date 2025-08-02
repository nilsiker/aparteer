class_name PauseMenu
extends Control

@onready var resume_button: Button = %ResumeButton
@onready var save_button: Button = %SaveButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	GameChannel.paused.connect(_on_game_paused)
	GameChannel.resumed.connect(_on_game_resumed)
	GameChannel.quitted.connect(_on_game_quitted)
	
	resume_button.pressed.connect(_on_resume_pressed)
	save_button.pressed.connect(_on_save_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	visible = false
	
func _on_game_paused():
	visible = true
	resume_button.grab_focus()
	
func _on_game_resumed():
	visible = false
	
func _on_game_quitted():
	visible = false

func _on_resume_pressed() -> void:
	GameChannel.resume()
	
func _on_save_pressed() -> void:
	GameChannel.save(SaveManager.dummy())
	
func _on_quit_pressed() -> void:
	AppChannel.obscure(GameChannel.quit)
	
