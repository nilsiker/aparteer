extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OptionsChannel.master_volume_changed.connect(_on_master_volume_changed)
	OptionsChannel.music_volume_changed.connect(_on_music_volume_changed)
	OptionsChannel.sfx_volume_changed.connect(_on_sfx_volume_changed)

	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), _read_master_from_config())
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), _read_music_from_config())
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), _read_sfx_from_config())

func _process(_delta: float) -> void:
	print("Master Volume: " + str(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master"))))
	print("Music Volume: " + str(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Music"))))
	print("SFX Volume: " + str(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("SFX"))))

func _read_master_from_config() -> float:
	return Config.read_audio_setting("master_volume")

func _read_music_from_config() -> float:
	return Config.read_audio_setting("music_volume")

func _read_sfx_from_config() -> float:
	return Config.read_audio_setting("sfx_volume")

func _on_master_volume_changed(volume: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), volume)

func _on_music_volume_changed(volume: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), volume)

func _on_sfx_volume_changed(volume: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), volume)
