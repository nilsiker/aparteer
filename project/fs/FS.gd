class_name FS

static func _userdir(path) -> String:
	return "user://" + path

static func write_save(path: String, data: Variant) -> void:
	var file = FileAccess.open(_userdir(path), FileAccess.WRITE)
	if file:
		file.store_var(data, true)
		file.close()
	else:
		push_error("Failed to open file for writing: " + path)

static func read_save(path: String) -> Variant:
	var file = FileAccess.open(_userdir(path), FileAccess.READ)
	if file:
		var data = file.get_var(true)
		file.close()
		return data
	else:
		push_error("Failed to open file for reading: " + path)
		return null
