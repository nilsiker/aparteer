class_name GameState_InGame
extends LimboState


func _enter() -> void:
	GameChannel.saved.connect(_on_game_saved)
	GameChannel.quitted.connect(_on_game_quitted)
	
func _exit() -> void:
	GameChannel.saved.disconnect(_on_game_saved)
	GameChannel.quitted.disconnect(_on_game_quitted)


func _on_game_saved(save: SaveFile) -> void:
	print("TODO save game " + save.version)

func _on_game_quitted() -> void:
	dispatch(Game.To.STANDBY)
