extends Node2D

var built = true
var shooteble = false

var enemy_array = []
var enemy_selected


func _physics_process(_delta):
	if enemy_array.size() > 0 and built:
		select_enemy()
		turn()
	else:
		enemy_selected = null

	if shooteble and enemy_array.size() > 0 and built:
		shooteble = false
		shoot()
		get_node("ShootCooldown").start()

func select_enemy():
	var enemy_danger_array = []
	for i in enemy_array:
		enemy_danger_array.append(i.offset)
	var max_offset = enemy_danger_array.max()
	var enemy_index = enemy_danger_array.find(max_offset)
	enemy_selected = enemy_array[enemy_index]

func turn():
	get_node("Launcher").look_at(enemy_selected.position)
	

func _on_ShootArea_body_entered(body):
	if body.is_in_group("enemy"):
		enemy_array.append(body.get_parent())


func _on_ShootArea_body_exited(body):
	if body.is_in_group("enemy"):
		enemy_array.erase(body.get_parent())


func shoot():
	var projectile = load("res://RocketBullet.tscn").instance()
	projectile.position = get_node(".").position
	get_parent().get_parent().get_node("Bullets").add_child(projectile)


func _on_ShootCooldown_timeout():
	shooteble = true
