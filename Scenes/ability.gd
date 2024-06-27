extends Area2D

var vel_x : float = 400
var vel_y : float = 500

var lifetime : float = 3.0
var life_count : float

func _physics_process(delta):
	if life_count >= lifetime:
		queue_free()
	
	life_count += delta
	position.x += 1
	
