class_name PlayerState_Enabled
extends LimboState

func _enter() -> void:
	GameChannel.paused.connect(_on_game_paused)
	GameChannel.resumed.connect(_on_game_resumed)

func _exit() -> void:
	GameChannel.paused.disconnect(_on_game_paused)
	GameChannel.resumed.disconnect(_on_game_resumed)

func _on_game_paused() -> void:
	dispatch(Player2D.To.DISABLED)

func _on_game_resumed() -> void:
	dispatch(Player2D.To.IDLE)
