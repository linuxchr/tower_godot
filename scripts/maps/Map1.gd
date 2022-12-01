extends Node2D

var counter = 0
var gameOver = false

func _ready():
		get_parent().map_node = get_node(".")

func _on_EnemyTimer_timeout():
	if counter <= 10 and !gameOver:
		get_node("EnemyTimer").start()
		var new_ene = load("res://enemys/EnemyT1.tscn").instance()
		new_ene.position.y = 225
		new_ene.position.x = 0
		get_node("Enemys").add_child(new_ene, true)
		counter = counter + 1	


func _on_Goal_body_entered(body):
	if body.is_in_group("enemy"):
		get_parent().lifes -= 1
	body.queue_free()
	if get_parent().lifes == 0:
		get_parent().lose()
