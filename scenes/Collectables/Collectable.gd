extends Area2D

signal nuts_changed(nuts)

export(int) var nuts = 0

func _on_Collectable_body_entered(body: Node) -> void:
	emit_signal("nuts_changed", 1)
	queue_free()
