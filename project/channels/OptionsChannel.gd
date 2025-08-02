extends Node

# Display
signal fullscreen_toggled(fullscreen: bool)

# Audio
signal master_volume_changed(volume: float)
signal music_volume_changed(volume: float)
signal sfx_volume_changed(volume: float)

# Input
signal input_action_changed(action: String, event: InputEvent)
signal input_defaults_restored

# UI
signal ui_opened
signal controls_ui_opened

func toggle_fullscreen(fullscreen: bool) -> void:
	fullscreen_toggled.emit(fullscreen)

func set_master_volume(volume: float) -> void:
	master_volume_changed.emit(volume)

func set_music_volume(volume: float) -> void:
	music_volume_changed.emit(volume)

func set_sfx_volume(volume: float) -> void:
	sfx_volume_changed.emit(volume)

func change_input_action(action: String, event: InputEvent) -> void:
	input_action_changed.emit(action, event)

func restore_input_defaults() -> void:
	input_defaults_restored.emit()

func open_ui() -> void:
	ui_opened.emit()

func open_controls_menu() -> void:
	controls_ui_opened.emit()
