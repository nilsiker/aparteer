extends PlayerState_Enabled

var input: PlayerInput2D
var sprite: PlayerSprite

func _setup() -> void:
	input = blackboard.get_var(&"input") as PlayerInput2D
	sprite = blackboard.get_var(&"sprite") as PlayerSprite

func _enter() -> void:
	super._enter()
	input.input_vector_changed.connect(_on_input_vector_changed)
	sprite.idle()
	

func _exit() -> void:
	super._exit()
	input.input_vector_changed.disconnect(_on_input_vector_changed)

func _on_input_vector_changed(input_vector: Vector2) -> void:
	if input_vector != Vector2.ZERO:
		dispatch(Player2D.To.MOVING)
