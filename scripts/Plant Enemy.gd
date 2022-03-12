extends KinematicBody2D

#Spawn location of projectile
onready var projectileSpawn:Node2D = $ProjectileSpawn
onready var state_machine = $AnimationTree.get("parameters/playback")

#The path of the scene that will spawn as projectile can be changed in editor if needed
export var projectileToSpawn:String = "res://scenes/Projectiles/Plant Projectile/Plant Projectile.tscn"
#How much force the rigidbody projectile will apply on instance
export var projectileForceX:int = -50
export var delayBetweenShots:float = 5
export var desiredSpitDamage = 10
export var desiredBiteDamage = 40
export var CanBite = true
export var CanSpit = true
export var isFliped = false
export var health = 20

var player:Player = null

#Do note the plant enemy does damage by colliding projectiles and not itself, refer to plant projectile or
#its projectile its spawning

func _ready():
	if isFliped:
		flip()
	var timer = $DelayBetweenShots
	timer.wait_time = delayBetweenShots
	
func hurt(var d:float = 0):
#	state_machine.travel("Hurt")
	health -= d
#	print("health: ", health)
	if health <= 0:
		die()
	
func die():
#	state_machine.travel("Die")
	#print("lives: ", lives)
	queue_free()

#Flip the sprite around and direction of shooting if needed
func flip():
	projectileSpawn.position = Vector2(-projectileSpawn.position.x,projectileSpawn.position.y)
	$PlayerBiteArea/CollisionShape2D.position = Vector2(-$PlayerBiteArea/CollisionShape2D.position.x,$PlayerBiteArea/CollisionShape2D.position.y)
	projectileForceX *= -1
	$sprite.flip_h = !$sprite.flip_h
	
#The function that handles the shooting of the desired projectile
func shoot():
	var loadedProjectile = load(projectileToSpawn)
	var projectile:RigidBody2D = loadedProjectile.instance()
	get_parent().add_child(projectile)
	projectile.damage = desiredSpitDamage
	projectile.global_position = projectileSpawn.global_position
	projectile.linear_velocity.x = projectileForceX
	
func bite():
	if player:
		player.hurt(desiredBiteDamage)


func _on_DelayBetweenShots_timeout():
	if CanSpit:
		state_machine.travel("spit")
	

func _on_DelayBetweenBites_timeout():
	if player and CanBite:
		state_machine.travel("bite")

func _on_PlayerBiteArea_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_PlayerBiteArea_body_exited(body):
	if body.is_in_group("Player"):
		player = null


