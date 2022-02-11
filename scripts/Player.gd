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

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("move_right"):
		motion.x += ACCEL
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
		
	elif Input.is_action_pressed("move_left"):
		motion.x += -ACCEL
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
		
	else:
		motion.x = lerp(motion.x,0,FRICTION)
		if is_on_floor():
			$AnimatedSprite.play("Default")
		else:
			pass
			#$AnimatedSprite.play("Default")
	
	motion = move_and_slide(motion,UP)
	
	if Input.is_action_pressed("attack"):
		$AnimatedSprite.play("Attack2")
	
	if is_on_floor():
		if Input.is_action_just_pressed("move_jump"):
			motion.y = -JUMPFORCE
			$AnimatedSprite.play("Jump")
	else:
		if motion.y > 0:
			$AnimatedSprite.play("Fall")
			

func animate(var animName, var xMotion):
	pass
