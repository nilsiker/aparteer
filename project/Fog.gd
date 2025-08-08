extends Sprite2D

func _process(delta: float) -> void:
	texture.noise.offset.x += delta * 3
	texture.noise.offset.z += delta * 3
