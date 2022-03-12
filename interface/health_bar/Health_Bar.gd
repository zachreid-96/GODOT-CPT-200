extends HBoxContainer

signal maximum_changed()


func initialize():
	emit_signal("maximum_changed")

func _on_Interface_health_updated():
	emit_signal("maximum_changed")

func _on_Player_health_changed():
	emit_signal("maximum_changed")
