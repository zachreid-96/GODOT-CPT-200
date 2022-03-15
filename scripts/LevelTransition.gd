extends Area2D

var player:Player

func _on_LevelTransition_body_entered(body):
	if body.get_class() == "Player":
		get_tree().change_scene("res://scenes/Maps/Designed_Levels/Level_2.tscn")
	else:
		pass
