extends Control

signal health_updated(value)
signal nuts_updated(count)

func _ready():
	var health_node = null
	for node in get_tree().get_nodes_in_group("player"):
		if node.name == "Player2":
			health_node = node.get_node("Health")
			break
	get_node("Health_Bar").initialize(health_node.max_health)
	get_node("Collectibles/Nuts_Counter").initialize()
		

func _on_Health_health_changed(health):
	emit_signal("health_updated", health)

func _on_Nuts_nuts_changed(count):
	emit_signal("nuts_updated", count)
