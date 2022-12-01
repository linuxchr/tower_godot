extends KinematicBody2D

var enemy_array = []
var enemy_selected

var destination = false
var runned = false

var velocity = Vector2()
var target = Vector2()
var speed = 200



func select_enemy():
	var enemy_danger_array = []
	for i in enemy_array:
		enemy_danger_array.append(i.offset)
	var max_offset = enemy_danger_array.max()
	var enemy_index = enemy_danger_array.find(max_offset)
	enemy_selected = enemy_array[enemy_index]
	destination = true


func _physics_process(delta):
	if !destination and enemy_array.size() > 0:
		select_enemy()
	if destination and enemy_array.size() != 0 and !runned:
		get_node(".").look_at(enemy_selected.position)
		target = enemy_selected.position
		runned = true
		shoot()
	if destination and runned:
		move_and_slide(velocity)


func shoot():
	velocity = position.direction_to(target) * speed

func _on_ShotAerea_body_entered(body):
	if body.is_in_group("enemy"):
		enemy_array.append(body.get_parent())


func _on_ShotAerea_body_exited(body):
	if body.is_in_group("enemy"):
		enemy_array.erase(body.get_parent())
