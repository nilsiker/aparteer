class_name NodeExt

static func get_parent(node: Node, cls: String) -> Node:
	var parent = node.get_parent()
	if not parent: return parent
	
	while parent:
		if not parent.get_script():
			parent = parent.get_parent()
		elif parent.get_script().get_global_name() == cls:
			return parent
		else: parent = parent.get_parent()
	return parent

## Removes a node from its parent and queues it for deletion.
## 
## Returns a null reference, handy for clearing an assigned reference.
static func remove(node: Node) -> Node:
	if node.get_parent():
		node.get_parent().remove_child(node)
	node.name += "_to_remove"
	node.queue_free()
	return null


## Clears all children from a node
static func clear_children(node: Node) -> void:
	node.get_children().map(remove)
