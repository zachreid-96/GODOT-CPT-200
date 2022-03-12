extends Control

signal health_updated()
signal nuts_updated()

func _ready():
	get_node("Health_Bar").initialize()
	get_node("Collectibles/Nuts_Counter").initialize()
	get_node("Lives_Counter").initialize()
	

func _on_Health_health_changed():
	emit_signal("health_updated")

func _on_Nuts_nuts_changed():
	emit_signal("nuts_updated")
