extends Node

signal health_changed(health)

var health = 0
export(int) var max_health = 100

func _ready():
	health = max_health
	emit_signal("health_changed", health)

func take_damage(damage):
	health = damage
	health = max(0, health)
	emit_signal("health_changed", health)
