@tool
extends InteractableArea2D

@export_file var to: String
 
var from: String

func _ready() -> void:
	print(NodeExt.get_parent(self, "Level"))
	from = NodeExt.get_parent(self, "Level").scene_file_path

func interact() -> void:
	WorldChannel.transition(to, from)
