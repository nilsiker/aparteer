extends Control

@export var debug_hsm_ui_scene: PackedScene

@onready var hsms: Node = %HSMs


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DebugChannel.hsm_added.connect(_on_hsm_added)
	DebugChannel.hsm_removed.connect(_on_hsm_removed)

	NodeExt.clear_children(hsms)

func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_toggle_ui"):
		visible = !visible


func _add_hsm(hsm) -> void:
	var ui = debug_hsm_ui_scene.instantiate()
	ui.hsm = hsm
	hsms.add_child(ui)

func _remove_hsm(hsm: LimboHSM) -> void:
	var node = hsms.get_children().filter(func(child): return child.hsm == hsm).front()
	hsms.remove_child(node)

#region Signal Handlers
func _on_hsm_added(hsm: LimboHSM) -> void: _add_hsm(hsm)

func _on_hsm_removed(hsm: LimboHSM) -> void: _remove_hsm(hsm)
#endregion
