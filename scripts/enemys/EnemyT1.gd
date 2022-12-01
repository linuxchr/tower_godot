extends PathFollow2D

var speed = 150


func _physics_process(delta):
	move(delta)
	
	
func move(delta):
	set_offset(get_offset() + speed * delta)


func _on_DestField_body_entered(body):
	if body.is_in_group("rbul"):
		get_node(".").queue_free()
		body.queue_free()
