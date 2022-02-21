extends KinematicBody2D
class_name Player
func get_class(): return "Player"

const UP = Vector2(0,-1)
export var GRAVITY = 20
export var MAXFALLSPEED = 200
export var MAXSPEED = 80
export var JUMPFORCE = 350
export var ACCEL = 10
export var FRICTION = 1

var speed = MAXSPEED
var motion = Vector2()

var facing_left = false
var state_machine
var attacks = ["Attack1","Attack2","Attack3"]

var health = 100.0
var lives = 5

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	
func get_input():
	#var current = state_machine.get_current_node()
	
	#Set limits for x-motion
	motion.x = clamp(motion.x, -speed, speed)
	
	#Set correct collision if ducking
	if Input.is_action_pressed("move_down"):
		$CollisionStand.disabled = true
		move_x()
	else:
		$CollisionStand.disabled = false
		
	#Attack animation
	if Input.is_action_pressed("attack"):
		attack()
	
	#Calculate motion and sprite direction based on left/right keys
	elif Input.is_action_pressed("move_right"):
		$Sprite.flip_h = false
		$CollisionStand.position.x = -2
		$CollisionDuck.position.x = -2
		$Sprite/SwordHit.scale.x = 1
		motion.x += ACCEL
		move_x()
	elif Input.is_action_pressed("move_left"):
		$Sprite.flip_h = true
		$CollisionStand.position.x = 2
		$CollisionDuck.position.x = 2
		$Sprite/SwordHit.scale.x = -1
		motion.x -= ACCEL
		move_x()
	#If neither is pressed and on the floor
	elif is_on_floor():
		#Slow down on the floor
		motion.x = lerp(motion.x, 0, FRICTION)
		move_x()

func _physics_process(_delta):
	get_input()
	if health <= 0:
		die()
	#Establish gravity
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	#Jump is pressed
	if is_on_floor():
		#Jump is pressed
		if Input.is_action_pressed("move_jump"):
			motion.y = -JUMPFORCE
			jump()
	else:
		if motion.y > 0:
			fall()

	#Re-evaluate motion using updated values
	motion = move_and_slide(motion,UP)
	
func hurt(var d:float = 0):
	state_machine.travel("Hurt")
	health -= d
	#print("health: ", health)
	
func die():
	state_machine.travel("Die")
	lives -= 1
	#print("lives: ", lives)
	if lives > 0:
		respawn()
	else:
		set_physics_process(false)

func fall():
	state_machine.travel("Fall")
	
func jump():
	state_machine.travel("Jump")

func attack():
	#state_machine.travel(attacks[randi() % 2])
	state_machine.travel("Attack3")

func move_x():
	if is_on_floor():
		if Input.is_action_pressed("move_down"):
			state_machine.travel("Duck")
			speed = MAXSPEED / 2
		elif Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right"):
			state_machine.travel("Run")
			speed = MAXSPEED
		else:
			state_machine.travel("Default")
			speed = MAXSPEED
	
func _on_SwordHit_area_entered(area):
		if area.is_in_group("hurtbox"):
			area.take_damage()

func respawn():
	health = 100
	position.x = 8
	position.y = -2
