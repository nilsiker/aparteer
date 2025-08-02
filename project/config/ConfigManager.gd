extends Node

func _ready() -> void:
	OptionsChannel.fullscreen_toggled.connect(_on_fullscreen_toggled)
	OptionsChannel.master_volume_changed.connect(_on_master_volume_changed)
	OptionsChannel.music_volume_changed.connect(_on_music_volume_changed)
	OptionsChannel.sfx_volume_changed.connect(_on_sfx_volume_changed)
	OptionsChannel.input_action_changed.connect(_on_input_action_changed)

func _on_fullscreen_toggled(fullscreen: bool) -> void:
	Config.write_display_setting("fullscreen", fullscreen)

func _on_master_volume_changed(volume: float) -> void:
	Config.write_audio_setting("master_volume", volume)

func _on_music_volume_changed(volume: float) -> void:
	Config.write_audio_setting("music_volume", volume)

func _on_sfx_volume_changed(volume: float) -> void:
	Config.write_audio_setting("sfx_volume", volume)

func _on_input_action_changed(action: String, event: InputEvent) -> void:
	InputConfig.set_action_key(action, event)
