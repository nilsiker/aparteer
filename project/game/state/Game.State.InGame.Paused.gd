extends GameState_InGame

func _setup() -> void:
	add_event_handler(Game.Event.PAUSE, _on_game_event_pause)

func _enter() -> void:
	super._enter()
	GameChannel.resumed.connect(_on_game_resumed)

	get_tree().paused = true	
	
func _exit() -> void:
	super._exit()
	GameChannel.resumed.disconnect(_on_game_resumed)

	get_tree().paused = false


func _on_game_resumed():
	dispatch(Game.To.INGAME_PLAYING)
	return true

func _on_game_event_pause():
	GameChannel.resume()
	return true