class_name SaveManager
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameChannel.saved.connect(_on_game_saved)
	GameChannel.loaded.connect(_on_game_loaded)

func _on_game_saved(save_file: SaveFile) -> void:
	FS.write_save("save_game.dat", save_file)

func _on_game_loaded() -> SaveFile:
	var data = FS.read_save("save_game.dat") as SaveFile
	if data:
		print(data.version)
	else:
		print("Failed to load game")
	return data

static var SAVE_FILE = dummy()

static func dummy() -> SaveFile:
	var save_file = SaveFile.new()
	var game_data = GameData.new()
	var player_data = PlayerData.new()
	var world_data = WorldData.new()
	game_data.player_data = player_data
	game_data.world_data = world_data
	save_file.game_data = game_data
	return save_file
