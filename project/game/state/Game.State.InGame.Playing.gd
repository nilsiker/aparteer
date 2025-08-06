extends GameState_InGame

func _setup() -> void:
	add_event_handler(Game.Event.PAUSE, _on_game_pause_input)

func _enter() -> void:
	super._enter()
	GameChannel.paused.connect(_on_game_paused)
	
func _exit() -> void:
	super._exit()
	GameChannel.paused.disconnect(_on_game_paused)
	
func _on_game_pause_input():
	GameChannel.pause(true)
	return true

func _on_game_paused(by_player: bool) -> void:
	if by_player: dispatch(Game.To.INGAME_PAUSED_BYPLAYER)
	else: dispatch(Game.To.INGAME_PAUSED)
