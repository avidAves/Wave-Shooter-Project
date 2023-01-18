extends Node2D

export(Array, PackedScene) var enemies

func _ready():
	Global.node_creation_parent = self
	
func _exit_tree():
	Global.node_creation_parent = null


func _on_Enemy_spawn_timer_timeout():
	var enemy_position = Vector2(rand_range(-160,670), rand_range(-90,390))
	#Prevents spawning an enemy in the camera
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(rand_range(-160,670), rand_range(-90,390))
		
	var enemy_number = round(rand_range(0, enemies.size()-1))
	Global.instance_node(enemies[enemy_number],enemy_position,self)
	

func _on_Difficulty_timeout():
	if $Enemy_spawn_timer.wait_time > 0.25:
		$Enemy_spawn_timer.wait_time -= 0.1
