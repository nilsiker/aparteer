extends TabContainer

func _ready() -> void:
	tab_changed.connect(_on_tab_changed)
	
	visible = false


func _on_tab_changed(tab: int):
	visible = tab >= 0
