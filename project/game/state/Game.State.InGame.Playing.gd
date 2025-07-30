extends GameState_InGame

func _enter() -> void:
	super._enter()
	GameChannel.paused.connect(_on_game_paused)
	
func _exit() -> void:
	super._exit()
	GameChannel.paused.disconnect(_on_game_paused)
	
func _on_game_paused() -> void:
	dispatch(Game.To.INGAME_PAUSED)
