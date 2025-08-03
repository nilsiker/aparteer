extends Node

signal hsm_added(hsm: LimboHSM)
signal hsm_removed(hsm: LimboHSM)

func add_hsm(hsm: LimboHSM) -> void:
	hsm_added.emit(hsm)

func remove_hsm(hsm: LimboHSM) -> void:
	hsm_removed.emit(hsm)
