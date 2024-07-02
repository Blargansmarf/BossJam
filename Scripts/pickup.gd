extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		print("wow")
		get_node("../Player").thrown = false
		#get_node("../thrown_weapon").dead = true
		#queue_free()
