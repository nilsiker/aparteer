class_name Config

const DISPLAY_SECTION = "display"
const AUDIO_SECTION = "audio"

const CONFIG_PATH = "user://options.cfg"

static func write_display_setting(name: String, value: Variant) -> void:
	var config = ConfigFile.new()
	config.load(CONFIG_PATH)
	config.set_value(DISPLAY_SECTION, name, value)
	config.save(CONFIG_PATH)

static func read_display_setting(name: String) -> Variant:
	var config = ConfigFile.new()
	config.load(CONFIG_PATH)
	return config.get_value(DISPLAY_SECTION, name)

static func write_audio_setting(name: String, value: Variant) -> void:
	var config = ConfigFile.new()
	config.load(CONFIG_PATH)
	config.set_value(AUDIO_SECTION, name, value)
	config.save(CONFIG_PATH)

static func read_audio_setting(name: String) -> Variant:
	var config = ConfigFile.new()
	config.load(CONFIG_PATH)
	return config.get_value(AUDIO_SECTION, name)