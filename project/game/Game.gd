class_name Game
extends Node

class To:
	const STANDBY = "To.Standby"
	const INGAME = "To.InGame"

@onready var hsm: LimboHSM = $HSM
@onready var standby: LimboState = $HSM/Standby
@onready var ingame: LimboState = $HSM/InGame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hsm.add_transition(standby, ingame, To.INGAME)
	hsm.add_transition(ingame, standby, To.STANDBY)

	hsm.initialize(self)
	hsm.set_active(true)
