extends LimboState

func _enter() -> void:
	GameChannel.started.connect(_on_game_started)

func _exit() -> void:
	GameChannel.started.disconnect(_on_game_started)

func _on_game_started() -> void:
	dispatch(Game.To.INGAME_PLAYING)
