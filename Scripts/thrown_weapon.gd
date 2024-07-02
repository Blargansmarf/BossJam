extends CharacterBody2D

var vel_x : float = 250
var vel_y : float = 900

var gravity : float = 20

func _physics_process(delta):
	if not is_on_floor():
		vel_y -= gravity
	else:
		vel_x = 0
		vel_y = 0
	
	velocity.x = vel_x
	velocity.y = -vel_y
	
	move_and_slide()


