extends CharacterBody2D

var thrown_scene = preload("res://Scenes/thrown_weapon.tscn")
var ability_scene = preload("res://Scenes/ability.tscn")
var throw_node

var move_speed : float = 250
var jump_height : float = 650
var gravity : float = 30
var dodge_mult : float = 3

#flags
var attacking : bool = false
var abilitying : bool = false
var throwing : bool = false
var dodging : bool = false
var thrown : bool = false
var facing_right : bool = true
var attacking_right : bool = true

#timers
var dodge_timer : float
var dodge_limit : float = .15
var ability_timer : float
var ability_limit : float = .2
var throw_timer : float
var throw_limit : float = .2

#attack frame trackers
var attack_frames_active_start : int = 5
var attack_frames_active_end : int = 15
var attack_frames_limit : int = 20
var attack_frames_current : int


func _physics_process(delta):
	##process offensive action
	if attacking or abilitying or throwing:
		if attacking:
			if attack_frames_current <= attack_frames_limit:
				if attack_frames_current >= attack_frames_active_start and attack_frames_current <= attack_frames_active_end:
					if attacking_right:
						get_node("AttackRight").process_mode = Node.PROCESS_MODE_INHERIT
						get_node("AttackRight").visible = true
					else:
						get_node("AttackLeft").process_mode = Node.PROCESS_MODE_INHERIT
						get_node("AttackLeft").visible = true
				elif attack_frames_current > attack_frames_active_end:
					if attacking_right:
						get_node("AttackRight").process_mode = Node.PROCESS_MODE_DISABLED
						get_node("AttackRight").visible = false
					else:
						get_node("AttackLeft").process_mode = Node.PROCESS_MODE_DISABLED
						get_node("AttackLeft").visible = false
				attack_frames_current += 1
			else:
				attacking = false
				
		elif abilitying:
			if ability_timer <= ability_limit:
				ability_timer += delta
			else:
				abilitying = false
		else:
			if throw_timer <= throw_limit:
				throw_timer += delta
			else:
				throwing = false
	else:
		##check for attacks only if no other attacks are happening
		if not attacking and not abilitying and not throwing:
			if Input.is_action_just_pressed("attack"):
				attacking = true
				attacking_right = facing_right
				attack_frames_current = 0 
			if Input.is_action_just_pressed("ability"):
				abilitying = true
				ability_timer = 0
				var ability_node = ability_scene.instantiate()
				ability_node.position = position
				if not facing_right:
					ability_node.vel_x *= -1
				get_parent().add_child(ability_node)
			if Input.is_action_just_pressed("throw") and not thrown:
				throwing = true
				thrown = true
				throw_timer = 0
				throw_node = thrown_scene.instantiate()
				throw_node.position = position
				if not facing_right:
					throw_node.vel_x *= -1
				get_parent().add_child(throw_node)
		if Input.is_action_just_pressed("swap") and thrown:
			var temp_pos = position
			var temp_vel = velocity
			position = throw_node.position
			velocity = throw_node.velocity
			throw_node.position = temp_pos
			throw_node.velocity = temp_vel
			
	
	##process dodge action
	if dodging:
		dodge_timer += delta
		if dodge_timer >= dodge_limit:
			dodging = false
			dodge_timer = 0
			
	##check for other movements when not dodging
	else:
		##apply gravity
		if not is_on_floor():
			velocity.y += gravity
		
		##movement
		if Input.is_action_pressed("left"):
			facing_right = false
			velocity.x = -move_speed
		elif Input.is_action_pressed("right"):
			facing_right = true
			velocity.x = move_speed
		else:
			velocity.x = 0
		
		##jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = -jump_height
		
		##dodge
		if Input.is_action_just_pressed("dodge") and not dodging:
			dodging = true
			velocity.y = 0
			if facing_right:
				velocity.x = move_speed * dodge_mult
			else:
				velocity.x = -move_speed * dodge_mult
	
	move_and_slide()
