extends HBoxContainer

signal maximum_changed(maximum)

var maximum = 100
var current_health = 0

func initialize(max_value):
	maximum = max_value
	emit_signal("maximum_changed", maximum)

func _on_Interface_health_updated(damage):
	current_health = damage
	emit_signal("maximum_changed", current_health)

func _on_Player2_health_changed(damage):
	current_health = damage
	emit_signal("maximum_changed", current_health)
