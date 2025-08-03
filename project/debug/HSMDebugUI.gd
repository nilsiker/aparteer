extends HBoxContainer

@onready var _name: Label = $Name
@onready var _info: Label = $Info

var hsm: LimboHSM


# Called when the hsm enters the scene tree for the first time.
func _ready() -> void:
	_name.text = hsm.get_parent().name if hsm else &"Error"
	_info.text = "Node not set."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not hsm: return

	var debug_info: String = hsm.get_active_state().name if hsm.get_active_state() else &"No active state"
	_info.text = debug_info
