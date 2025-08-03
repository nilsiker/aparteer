extends PanelContainer

signal closed

@export var initial_focus: Node

@onready var fullscreen_button: Button = %FullscreenCheckButton
@onready var master_volume_slider: Slider = %MasterVolumeSlider
@onready var music_volume_slider: Slider = %MusicVolumeSlider
@onready var sfx_volume_slider: Slider = %SFXVolumeSlider

@onready var close_button: Button = %CloseButton
func _on_controls_button_pressed() -> void:
	OptionsChannel.open_controls_menu()
	
func _ready() -> void:
	GameChannel.starting.connect(_on_game_starting)
	GameChannel.resumed.connect(_on_game_resumed)
	GameChannel.quitted.connect(_on_game_quitted)

	OptionsChannel.ui_opened.connect(_on_ui_opened)

	close_button.pressed.connect(_on_close_button_pressed)

	fullscreen_button.toggled.connect(_on_fullscreen_toggled)
	master_volume_slider.value_changed.connect(_on_master_volume_changed)
	music_volume_slider.value_changed.connect(_on_music_volume_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_volume_changed)

	master_volume_slider.value = Config.read_audio_setting("master_volume")
	music_volume_slider.value = Config.read_audio_setting("music_volume")
	sfx_volume_slider.value = Config.read_audio_setting("sfx_volume")

	visible = false

func _on_game_starting() -> void:
	visible = false

func _on_game_resumed() -> void:
	visible = false

func _on_game_quitted() -> void:
	visible = false

func _on_fullscreen_toggled(pressed: bool) -> void:
	OptionsChannel.toggle_fullscreen(pressed)

func _on_master_volume_changed(value: float) -> void:
	OptionsChannel.set_master_volume(value)

func _on_music_volume_changed(value: float) -> void:
	OptionsChannel.set_music_volume(value)

func _on_sfx_volume_changed(value: float) -> void:
	OptionsChannel.set_sfx_volume(value)

func _on_close_button_pressed() -> void:
	visible = false
	closed.emit()

func _on_ui_opened() -> void:
	visible = true
	initial_focus.grab_focus()
