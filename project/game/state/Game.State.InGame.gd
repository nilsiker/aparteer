class_name GameStateInGame
extends LimboHSM

class To:
	const PAUSED = "To.Paused"
	const PLAYING = "To.Playing"

@onready var playing: LimboState = $Playing
@onready var paused: LimboState = $Paused

func _setup() -> void:
	add_transition(playing, paused, To.PAUSED)
	add_transition(paused, playing, To.PLAYING)
	
func _enter() -> void:
	print("entering ingame state")
