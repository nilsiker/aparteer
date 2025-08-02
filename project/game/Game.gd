class_name Game
extends Node

class To:
	const STANDBY = "To.Standby" 
	const INGAME_PLAYING = "To.InGame.Playing"
	const INGAME_PAUSED = "To.InGame.Paused"
	
class Event:
	const PAUSE = "pause"

@onready var hsm: LimboHSM = $HSM
@onready var standby: LimboState = $HSM/Standby
@onready var playing: LimboState = $HSM/InGame_Playing
@onready var paused: LimboState = $HSM/InGame_Paused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hsm.active_state_changed.connect(_on_active_state_changed)
	
	hsm.add_transition(standby, playing, To.INGAME_PLAYING)
	hsm.add_transition(hsm.ANYSTATE, standby, To.STANDBY)
	hsm.add_transition(playing, paused, To.INGAME_PAUSED)
	hsm.add_transition(paused, playing, To.INGAME_PLAYING)
	
	hsm.initialize(self)
	hsm.set_active(true)
	
func _on_active_state_changed(curr: LimboState, prev: LimboState):
	print("Game: " + (prev.name if prev else &"none") + " -> " + curr.name)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
			hsm.dispatch(Event.PAUSE)
