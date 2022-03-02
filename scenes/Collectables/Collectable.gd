extends Area2D

func _on_Collectable_body_entered(body: Node) -> void:
	queue_free()
