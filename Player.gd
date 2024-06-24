extends CharacterBody2D

var move_speed : float = 500
var jump_height : float = 500
var gravity : float = 100

#flags
var attacking : bool
var dodging : bool
var thrown : bool


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
	
	if Input.is_action_pressed("left"):
		velocity.x = -move_speed
	elif Input.is_action_pressed("right"):
		velocity.x = move_speed
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_height
	
	move_and_slide()
