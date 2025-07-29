extends LimboState

func _enter() -> void:
	print("Entering InGame.Paused")
	get_tree().paused = true

func _exit() -> void:
	get_tree().paused = false
