extends Area2D

var player:Player

func _on_Collectable_body_entered(body: Node) -> void:
	if body.get_class() == "Player":
		player = body
		player.collect()
		queue_free()
