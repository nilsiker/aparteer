extends LimboState

func _enter() -> void:
	GameChannel.readied.connect(_on_game_readied)
	GameChannel.resumed.connect(_on_game_resumed)

func _exit() -> void:
	GameChannel.readied.disconnect(_on_game_readied)
	GameChannel.resumed.disconnect(_on_game_resumed)

func _on_game_readied() -> void:
	print("Game readied, transitioning to IDLE state")
	dispatch(Player2D.To.IDLE)

func _on_game_resumed() -> void:
	dispatch(Player2D.To.IDLE)