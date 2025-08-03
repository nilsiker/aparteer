extends PlayerState_Enabled

var input: PlayerInput2D
var body: CharacterBody2D
var sprite: PlayerSprite

func _setup() -> void:
	body = agent as CharacterBody2D
	input = blackboard.get_var(&"input") as PlayerInput2D
	sprite = blackboard.get_var(&"sprite") as PlayerSprite

func _enter() -> void:
	super._enter()
	input.input_vector_changed.connect(_on_input_vector_changed)

	sprite.walk()
	sprite.face(input.input_vector)

func _exit() -> void:
	super._exit()
	input.input_vector_changed.disconnect(_on_input_vector_changed)

func _update(delta: float) -> void:
	_update_velocity(delta)

	body.move_and_slide()

	if body.velocity != Vector2.ZERO:
		dispatch(Player2D.Out.MOVE)
	else:
		dispatch(Player2D.To.IDLE)

func _update_velocity(delta: float) -> void:
	body.velocity = body.velocity.move_toward(input.input_vector * body.speed, body.acceleration * delta)

func _on_input_vector_changed(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO: return
	sprite.face(input_vector)
