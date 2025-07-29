class_name PlayerManager
extends Node

@export var player_scene: PackedScene
@export var player_parent: Node

var player: Node3D = null

func _ready() -> void:
	PlayerChannel.spawn.connect(_on_player_spawn)
	PlayerChannel.despawn.connect(_on_player_despawn)

func _on_player_spawn(transform: Transform3D) -> void:
	player = player_scene.instantiate()
	player.transform = transform
	add_child(player)

func _on_player_despawn() -> void:
	if player:
		player.queue_free()