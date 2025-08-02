class_name PauseMenu
extends Control

@onready var resume_button: Button = %ResumeButton
@onready var save_button: Button = %SaveLoadButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton
@onready var anim: AnimationPlayer = %Anim

func _ready() -> void:
	GameChannel.paused.connect(_on_game_paused)
	GameChannel.resumed.connect(_on_game_resumed)
	GameChannel.quitted.connect(_on_game_quitted)
	
	resume_button.pressed.connect(_on_resume_pressed)
	save_button.pressed.connect(_on_save_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	visible = false
	
func open() -> void:
	anim.play("show")
	resume_button.grab_focus()

func close() -> void:
	anim.play("hide")

func _on_game_paused(): open()
	
func _on_game_resumed(): close()

func _on_game_quitted(): close()

func _on_resume_pressed() -> void:
	GameChannel.resume()
	
func _on_save_pressed() -> void:
	GameChannel.save(SaveManager.dummy())
	
func _on_options_pressed() -> void:
	OptionsChannel.open_ui()
	
func _on_quit_pressed() -> void:
	close()
	AppChannel.obscure(GameChannel.quit)

func _on_options_closed() -> void:
	if visible: options_button.grab_focus()
	
func _on_controls_closed() -> void:
	if visible: options_button.grab_focus()
