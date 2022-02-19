extends Area2D

func _on_Slime_body_entered(body: Node) -> void:
	if body.get_class() == "Player":
		var player:Player = body
		player.respawn()
		player.hurt(10)
		
