extends Node

@onready var blackout: AnimationPlayer = %BlackoutAnim

@export var obscure_delay: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AppChannel.quitted.connect(_on_app_quitted)
	AppChannel.obscured.connect(_on_app_obscured)

	_register_hsms_for_debug()
	
func _register_hsms_for_debug() -> void:
	for hsm in find_children("*", "LimboHSM", true):
		DebugChannel.add_hsm(hsm)
	

func _on_app_quitted() -> void:
	get_tree().quit()

func _on_app_obscured(callback: Callable) -> void:
	blackout.play("obscure")
	await blackout.animation_finished
	await get_tree().create_timer(obscure_delay).timeout
	callback.call()
	blackout.play("reveal")
	AppChannel.reveal()
