extends Control


@onready var anim: AnimationPlayer = %Anim

func _ready() -> void:
	# Connect to the game state changes
	GameChannel.readied.connect(_on_game_readied)
	GameChannel.paused.connect(_on_game_paused)
	GameChannel.resumed.connect(_on_game_resumed)

func _on_game_readied() -> void:
	anim.play("show")

func _on_game_paused() -> void:
	anim.play("hide")

func _on_game_resumed() -> void:
	anim.play("show")
