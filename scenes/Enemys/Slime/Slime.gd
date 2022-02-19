extends Area2D

func _on_Slime_body_entered(body: Node) -> void:
	if body.get_name() == "Player":
		body.respawn()
