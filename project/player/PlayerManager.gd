class_name PlayerManager
extends Node

@export var player_scene: PackedScene
@export var player_parent: Node

var player: Node2D = null

func _ready() -> void:
	WorldChannel.transition_finished.connect(_on_world_transition_finished)
	PlayerChannel.spawn.connect(_on_player_spawn)
	PlayerChannel.despawn.connect(_on_player_despawn)

func _on_world_transition_finished(entrypoint: Node) -> void:
	print("TODO spawn player at ", entrypoint)

func _on_player_spawn(transform: Transform2D) -> void:
	player = player_scene.instantiate()
	player.transform = transform
	player_parent.add_child(player)

func _on_player_despawn() -> void:
	if player:
		player.name += "_to_remove"
		player.queue_free()
		player = null
	
