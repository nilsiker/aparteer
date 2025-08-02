class_name InputConfig

const INPUT_SECTION = "input"
const INPUT_CONFIG_PATH = "user://input.cfg"


static func get_action(action: String) -> InputEvent:
	var config = ConfigFile.new()
	config.load(INPUT_CONFIG_PATH)
	var event =  config.get_value(INPUT_SECTION, action, "not set")
	if event is InputEvent:
		return event
	return null

static func set_action_events(action: String, events: Array[InputEvent]) -> void:
	var config = ConfigFile.new()
	config.load(INPUT_CONFIG_PATH)
	config.set_value(INPUT_SECTION, action, events)
	config.save(INPUT_CONFIG_PATH)

static func get_input_map() -> Dictionary:
	var config = ConfigFile.new()
	config.load(INPUT_CONFIG_PATH)
	if not config.has_section(INPUT_SECTION): return {}

	var input_map = {}
	var actions = config.get_section_keys(INPUT_SECTION)
	for action in actions:
		input_map[action] = config.get_value(INPUT_SECTION, action)
	
	return input_map
	

static func delete() -> void:
	var config = ConfigFile.new()
	config.load(INPUT_CONFIG_PATH)
	config.erase_section(INPUT_SECTION)
	config.save(INPUT_CONFIG_PATH)
