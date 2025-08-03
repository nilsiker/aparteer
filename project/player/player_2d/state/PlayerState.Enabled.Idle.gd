extends PlayerState_Enabled

var body: CharacterBody2D
var input: PlayerInput2D
var sprite: PlayerSprite

func _setup() -> void:
	body = agent as CharacterBody2D
	input = blackboard.get_var(&"input") as PlayerInput2D
	sprite = blackboard.get_var(&"sprite") as PlayerSprite

func _enter() -> void:
	super._enter()
	input.input_vector_changed.connect(_on_input_vector_changed)
	input.interacted.connect(_on_input_interacted)

	if body.velocity != Vector2.ZERO: 
		dispatch(Player2D.To.MOVING)
		return
	
	sprite.idle()

func _exit() -> void:
	super._exit()
	input.input_vector_changed.disconnect(_on_input_vector_changed)
	input.interacted.disconnect(_on_input_interacted)


func _on_input_vector_changed(input_vector: Vector2) -> void:
	if input_vector != Vector2.ZERO:
		dispatch(Player2D.To.MOVING)

func _on_input_interacted() -> void: dispatch(Player2D.To.INTERACTING)
