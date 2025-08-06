class_name GameState_InGame_Paused
extends GameState_InGame

func _enter() -> void:
	super._enter()
	GameChannel.resumed.connect(_on_game_resumed)

	get_tree().paused = true	
	
func _exit() -> void:
	super._exit()
	GameChannel.resumed.disconnect(_on_game_resumed)

	get_tree().paused = false


func _on_game_resumed():
	print("resuming")
	dispatch(Game.To.INGAME_PLAYING)
