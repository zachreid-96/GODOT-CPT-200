extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damage = 10

func freeSelf():
	queue_free()

func _on_Timer_timeout():
	freeSelf()

func _on_Plant_Projectile_body_exited(body:Node):
	if body.is_in_group("Player"):
		body.hurt(damage)
		freeSelf()
