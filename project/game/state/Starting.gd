extends LimboState


func _enter() -> void:
	GameChannel.readied.connect(_on_game_readied)
	
	GameChannel.broadcast_starting()

func _exit() -> void:
	GameChannel.readied.disconnect(_on_game_readied)

func _on_game_readied() -> void:
	dispatch(Game.To.INGAME_PLAYING)