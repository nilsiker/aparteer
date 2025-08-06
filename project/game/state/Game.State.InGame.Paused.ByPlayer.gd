extends GameState_InGame_Paused

func _setup() -> void:
	add_event_handler(Game.Event.PAUSE, _on_game_pause_input)

func _on_game_pause_input():
	GameChannel.resume()
	return true
