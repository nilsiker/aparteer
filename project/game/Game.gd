class_name Game
extends Node

class To:
	const STANDBY = "To.Standby"
	const STARTING = "To.Starting"
	const LOADING = "To.Loading"
	const INGAME_PLAYING = "To.InGame.Playing"
	const INGAME_PAUSED = "To.InGame.Paused"
	const INGAME_PAUSED_BYPLAYER = "To.InGame.Paused.ByPlayer"
	
class Event:
	const PAUSE = "pause"

@onready var hsm: LimboHSM = $HSM

@onready var standby: LimboState = $HSM/Standby
@onready var starting: LimboState = $HSM/Starting
@onready var loading: LimboState = $HSM/Loading

@onready var playing: LimboState = $HSM/InGame_Playing
@onready var paused: LimboState = $HSM/InGame_Paused
@onready var paused_by_player: LimboState = $HSM/InGame_Paused_ByPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hsm.add_transition(standby, starting, To.STARTING)
	hsm.add_transition(starting, playing, To.INGAME_PLAYING)
	hsm.add_transition(playing, paused, To.INGAME_PAUSED)
	hsm.add_transition(paused, playing, To.INGAME_PLAYING)
	hsm.add_transition(playing, paused_by_player, To.INGAME_PAUSED_BYPLAYER)
	hsm.add_transition(paused_by_player, playing, To.INGAME_PLAYING)
	hsm.add_transition(hsm.ANYSTATE, standby, To.STANDBY)

	hsm.initialize(self)
	hsm.set_active(true)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
			hsm.dispatch(Event.PAUSE)
