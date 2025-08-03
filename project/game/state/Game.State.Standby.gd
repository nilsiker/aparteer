extends LimboState

func _enter() -> void:
	GameChannel.start_requested.connect(_on_game_start_requested)

func _exit() -> void:
	GameChannel.start_requested.disconnect(_on_game_start_requested)

func _on_game_start_requested() -> void:
	dispatch(Game.To.STARTING)
