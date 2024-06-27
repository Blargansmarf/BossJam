extends Area2D

var vel_x : float = 400
var vel_y : float = 500

func _physics_process(delta):
	position.x += 1
	position.y -= 1

