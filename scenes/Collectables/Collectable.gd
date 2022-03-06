extends Area2D

signal nuts_changed(nuts)

func _on_Collectable_body_entered(body: Node) -> void:
	
	emit_signal("nuts_changed", 1)
	queue_free()
