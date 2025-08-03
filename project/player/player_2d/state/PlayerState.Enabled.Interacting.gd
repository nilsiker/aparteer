extends PlayerState_Enabled

var input: PlayerInput2D
var sprite: PlayerSprite
var interactor: Interactor

var body: CharacterBody2D

func _setup() -> void:
	body = agent as CharacterBody2D
	input = blackboard.get_var(&"input") as PlayerInput2D
	sprite = blackboard.get_var(&"sprite") as PlayerSprite
	interactor = blackboard.get_var(&"interactor") as Interactor

	set_guard(interactor.has_interactable)


func _enter() -> void:
	super._enter()
	input.interacted.connect(_on_input_interacted)
	interactor.interaction_finished.connect(_on_interaction_finished)
	interactor.interaction_cancelled.connect(_on_interaction_finished)

	sprite.interact()
	interactor.interact()

	
func _exit() -> void:
	super._exit()
	input.interacted.disconnect(_on_input_interacted)
	interactor.interaction_finished.disconnect(_on_interaction_finished)
	interactor.interaction_cancelled.disconnect(_on_interaction_finished)

func _update(delta: float) -> void: 
	body.velocity = body.velocity.move_toward(Vector2.ZERO, body.acceleration * delta)
	body.move_and_slide()


func _on_input_interacted() -> void: interactor.cancel_interaction()

func _on_interaction_finished() -> void: 
	dispatch(Player2D.To.IDLE)
	print("Interaction finished, returning to idle state.")
