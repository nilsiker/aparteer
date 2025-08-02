class_name NodeExt

static func get_parent(node: Node, cls: String) -> Node:
	var parent = node.get_parent()
	
	while parent and not parent.is_class(cls):
		parent = parent.get_parent()
	
	return parent

