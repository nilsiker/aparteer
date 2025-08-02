extends Node

signal spawn(transform: Transform2D)
signal despawn

func spawn_player(transform: Transform2D) -> void:
    spawn.emit(transform)

func despawn_player() -> void:
    despawn.emit()