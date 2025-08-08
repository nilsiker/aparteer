@tool
extends Area2D

@export_file var to_path: String
var from_path: String

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if not from_path:
		from_path = NodeExt.get_parent(self, "Level").scene_file_path
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player2D:
		WorldChannel.transition(to_path, from_path)
