extends Node2D

var map_node
var build_valid = false
var gameOver = false
var lifes = 2


func _unhandled_input(event):
	if event.is_action_released("ui_accept") and !gameOver:
		build_tower()

func verify_pos(mousepos):
	var selected_tile = map_node.get_node("TowerEc").world_to_map(mousepos)
	if map_node.get_node("TowerEc").get_cellv(selected_tile) == -1:
		build_valid = true
	else:
		build_valid = false
	


func build_tower():
	var mousepos = get_global_mouse_position() 
	verify_pos(mousepos)
	if build_valid and !gameOver:
		var new_tower = load("res://RocketL1.tscn").instance()
		new_tower.position = mousepos
		get_node("Turrents").add_child(new_tower, true)
	
	
	

func lose():
	get_node("HUD/AnimationPlayer").play("LoseTextReveal")
	map_node.gameOver = true
	gameOver = true
	for i in get_tree().get_nodes_in_group("enemy"):
		i.queue_free()
	for i in get_node("Bullets").get_children():
		i.queue_free()


