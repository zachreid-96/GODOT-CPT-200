extends Node

signal nuts_changed(nuts)

func _ready():
	emit_signal("nuts_changed", 0)
