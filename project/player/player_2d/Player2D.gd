class_name Player2D
extends CharacterBody2D

class To:
	const IDLE = "To.Idle"
	const DISABLED = "To.Disabled"
	const MOVING = "To.Moving"
	const INTERACTING = "To.Interacting"

class Out:
	const MOVE = "Out.Move"

@onready var hsm: LimboHSM = $PlayerHSM
@onready var idle: LimboState = $PlayerHSM/Idle
@onready var disabled: LimboState = $PlayerHSM/Disabled
@onready var moving: LimboState = $PlayerHSM/Moving
@onready var interacting: LimboState = $PlayerHSM/Interacting

@export var speed = 75.0
@export var acceleration = 250.0

@export_category("Blackboard Bindings")
@export var input_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	DebugChannel.add_hsm(hsm)

	hsm.add_transition(hsm.ANYSTATE, idle, To.IDLE)
	hsm.add_transition(hsm.ANYSTATE, disabled, To.DISABLED)
	hsm.add_transition(idle, moving, To.MOVING)
	hsm.add_transition(interacting, idle, To.IDLE)
	hsm.add_transition(idle, interacting, To.INTERACTING)
	hsm.add_transition(moving, interacting, To.INTERACTING)


	hsm.initialize(self)
	hsm.set_active(true)

func _exit_tree() -> void:
	DebugChannel.remove_hsm(hsm)
