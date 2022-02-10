extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func freeSelf():
	queue_free()

func _on_Timer_timeout():
	freeSelf()
