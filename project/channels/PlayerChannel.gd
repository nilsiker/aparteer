extends Node

signal spawned(transform: Transform2D)
signal despawned

func spawn_player(transform: Transform2D) -> void:
    spawned.emit(transform)

func despawn_player() -> void:
    despawned.emit()