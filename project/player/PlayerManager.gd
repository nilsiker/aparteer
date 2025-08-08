class_name PlayerManager
extends Node

@export var player_scene: PackedScene
@export var player_parent: Node

var player: Node2D = null

func _ready() -> void:
	GameChannel.quitted.connect(_on_game_quitted)
	WorldChannel.transition_finished.connect(_on_world_transition_finished)

func _spawn(transform: Transform2D) -> void:
	if player: _despawn()

	player = player_scene.instantiate()
	player.transform = transform
	player_parent.add_child(player)

func _despawn() -> void: 
	NodeExt.remove(player)

func _on_game_quitted() -> void: _despawn()

func _on_world_transition_finished(entrypoint: Node) -> void:
	_spawn(entrypoint.global_transform)
	GameChannel.broadcast_readied()
