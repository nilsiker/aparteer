extends Control


@onready var anim: AnimationPlayer = %Anim

func _ready() -> void:
	# Connect to the game state changes
	GameChannel.started.connect(_on_game_started)
	GameChannel.paused.connect(_on_game_paused)
	GameChannel.resumed.connect(_on_game_resumed)

func _on_game_started() -> void:
	anim.play("show")

func _on_game_paused() -> void:
	anim.play("hide")

func _on_game_resumed() -> void:
	anim.play("show")