extends Area2D


func _on_Spikes_body_entered(body: Node) -> void:
	if body.get_name() == "Player":
		body.respawn()
