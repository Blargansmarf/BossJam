extends CharacterBody2D

var vel_x : float = 400
var vel_y : float = 0

var lifetime : float = 1.0
var life_count : float

func _physics_process(delta):
	if life_count >= lifetime:
		queue_free()
	
	life_count += delta
	
	velocity.x = vel_x
	velocity.y = vel_y
	
	move_and_slide()
	
