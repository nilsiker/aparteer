extends LimboState

func _enter() -> void:
	print("Entering Standby state")
	GameChannel.started.connect(_on_game_started)

func _exit() -> void:
	GameChannel.started.disconnect(_on_game_started)

func _on_game_started() -> void:
	dispatch(GameStateInGame.To.PAUSED)
