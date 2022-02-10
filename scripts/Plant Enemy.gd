extends KinematicBody2D

#Spawn location of projectile
onready var projectileSpawn:Node2D = $ProjectileSpawn

#The path of the scene that will spawn as projectile can be changed in editor if needed
export var projectileToSpawn:String = "res://scenes/Projectiles/Plant Projectile/Plant Projectile.tscn"
#How much force the rigidbody projectile will apply on instance
export var projectileForceX:int = -50


#func _ready():
#	flip()

#Flip the sprite around and direction of shooting if needed
func flip():
	projectileSpawn.position = Vector2(-projectileSpawn.position.x,projectileSpawn.position.y)
	projectileForceX *= -1
	$sprite.flip_h = !$sprite.flip_h
	
#The function that handles the shooting of the desired projectile
func shoot():
	var loadedProjectile = load(projectileToSpawn)
	var projectile:RigidBody2D = loadedProjectile.instance()
	get_parent().add_child(projectile)
	projectile.global_position = projectileSpawn.global_position
	projectile.linear_velocity.x = projectileForceX

func _on_DelayBetweenShots_timeout():
	shoot()
