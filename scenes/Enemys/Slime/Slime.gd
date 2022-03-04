extends Area2D

var damage = .5
var inArea = false
var player:Player

func _on_Slime_body_entered(body: Node) -> void:
	if body.get_class() == "Player":
		player = body
		inArea = true
		
func _on_Slime_body_exited(body: Node) -> void:
	if body.get_class() == "Player":
		player = body
		inArea = false

func _physics_process(_delta):
		if inArea:
			player.hurt(damage)
