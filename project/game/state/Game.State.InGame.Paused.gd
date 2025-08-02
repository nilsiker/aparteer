extends GameState_InGame

func _enter() -> void:
	super._enter()
	GameChannel.resumed.connect(_on_game_resumed)
	
func _exit() -> void:
	super._exit()
	GameChannel.resumed.disconnect(_on_game_resumed)

func _on_game_resumed():
	dispatch(Game.To.INGAME_PLAYING)
	return true
