class_name InputConfig

const INPUT_SECTION = "input"
const INPUT_CONFIG_PATH = "user://input.cfg"

static func get_action_key(action: String) -> String:
	var config = ConfigFile.new()
	config.load(INPUT_CONFIG_PATH)
	return config.get_value(INPUT_SECTION, action)

static func set_action_key(action: String, event: InputEvent) -> void:
	var config = ConfigFile.new()
	config.load(INPUT_CONFIG_PATH)
	config.set_value(INPUT_SECTION, action, event)
	config.save(INPUT_CONFIG_PATH)

static func get_input_map() -> Dictionary:
	var config = ConfigFile.new()
	config.load(INPUT_CONFIG_PATH)
	var input_map = {}
	var actions = config.get_section_keys(INPUT_SECTION)
	if not actions:
		return {}

	for action in actions:
		input_map[action] = config.get_value(INPUT_SECTION, action)
	return input_map
	

static func delete() -> void:
	var config = ConfigFile.new()
	config.load(INPUT_CONFIG_PATH)
	config.erase_section(INPUT_SECTION)
	config.save(INPUT_CONFIG_PATH)
