extends KinematicBody2D

const UP = Vector2(0,-1)
export var GRAVITY = 20
export var MAXFALLSPEED = 200
export var MAXSPEED = 80
export var JUMPFORCE = 320
export var ACCEL = 10
export var FRICTION = 0.2

var motion = Vector2()
var facing_right = true
var state_machine

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	#Establish gravity
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	#Set limits for x-motion
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	#Set correct collision if ducking
	if Input.is_action_pressed("move_down"):
		$CollisionStand.disabled = true
	else:
		$CollisionStand.disabled = false
	
	#Calculate motion and sprite direction based on left/right keys
	if Input.is_action_pressed("move_right"):
		motion.x += ACCEL
		$Sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		motion.x += -ACCEL
		$Sprite.flip_h = true
	#If neither is pressed and on the floor
	elif is_on_floor():
		#Slow down on the floor
		motion.x = lerp(motion.x,0,FRICTION)
	#Jump is pressed
		if Input.is_action_just_pressed("move_jump"):
			motion.y = -JUMPFORCE
	
	#Re-evaluate motion using updated values
	motion = move_and_slide(motion,UP)
	
	#if Input.is_action_pressed("attack"):
		#pass
