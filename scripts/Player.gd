extends KinematicBody2D


# Declare member variables here. Examples:
var velocity = Vector2.ZERO
export var MAX_SPEED = 140
export var ACCELERATION = 800
export var FRICTION = 600
export var GRAVITY = 400
var is_gravity_on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	jump()
	

func jump():
	if Input.is_action_just_pressed("move_jump"):
		velocity += (Vector2.UP * 1100)

func movement(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector = input_vector.normalized()
	
	#This makes it where friction is low in the air (keep this if you want more fluid like air)
	var friction = FRICTION
	if !is_on_floor():
		friction = 50
	
	#player moving
	if input_vector != Vector2.ZERO:
		#make velocity move towards player input (print the input_vector for values) and times it by max speed
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)

	#player NOT moving :o
	else:
		#Player aint moving start making the speed the player is at to 0
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	#Gravity variable, make this single digit go up or down for more stronger/weaker gravity
	velocity.y += GRAVITY*delta*5
	velocity = move_and_slide(velocity,Vector2.UP)

func _on_GravityEnableDelay_timeout():
	is_gravity_on = true
