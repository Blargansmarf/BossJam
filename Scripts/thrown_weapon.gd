extends CharacterBody2D

var pickup_scene = preload("res://Scenes/pickup_weapon.tscn")
var pickup_instance

var dead : bool = false
var pickup_ready : bool = false

var vel_x : float = 250
var vel_y : float = 900

var gravity : float = 20

var pickup_timer : float = 0
var pickup_available : float = 1.0

func _physics_process(delta):
	if dead:
		queue_free()
	
	if not pickup_ready and pickup_timer >= pickup_available:
		pickup_ready = true
		pickup_instance = pickup_scene.instantiate()
		get_parent().add_child(pickup_instance)
	elif pickup_timer < pickup_available:
		pickup_timer += delta
	
	if pickup_ready:
		pass
		#pickup_instance.position = position
	
	if not is_on_floor():
		vel_y -= gravity
	else:
		vel_x = 0
		vel_y = 0
	
	velocity.x = vel_x
	velocity.y = -vel_y
	
	move_and_slide()


