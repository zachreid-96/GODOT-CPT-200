extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 320
const ACCEL = 10
const FRICTION = 0.2

var motion = Vector2()
var facing_right = true

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("move_right"):
		motion.x += ACCEL
		facing_right = true
		$AnimationPlayer.play("Run")
		
	elif Input.is_action_pressed("move_left"):
		motion.x += -ACCEL
		facing_right = false
		$AnimationPlayer.play("Run")
		
	else:
		motion.x = lerp(motion.x,0,FRICTION)
		if is_on_floor():
			$AnimationPlayer.play("idle")
		else:
			$AnimationPlayer.stop(true)
	
	motion = move_and_slide(motion,UP)
	
	if is_on_floor():
		if Input.is_action_just_pressed("move_jump"):
			motion.y = -JUMPFORCE
			$AnimationPlayer.play("Jump")
