extends Area2D

var damage = .5
var inArea = false
var player:Player

func _on_Spikes_body_entered(body: Node) -> void:
		if body.get_class() == "Player":
			player = body
			player.hurt(100)
