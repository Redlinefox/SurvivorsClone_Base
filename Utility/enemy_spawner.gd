extends Node2D

# Set a variable that contains an Array of SpawnInfo  
@export var spawns : Array[SpawnInfo]

@onready var player = get_tree().get_first_node_in_group("player")

var time = 0


func _on_timer_timeout() -> void:
	time += 1
	
	for i in spawns:
		# If the time counter is between "start" and "end" 
		print("spawning enemies")
		if time >= i.time_start and time <= i.time_end:
			# check if the spawn delay counter is less than the spawn delay time, if yes advance spawn delay counter by 1.
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				# reset the spawn delay counter to 0, load the enemy resource, set a counter to 0
				i.spawn_delay_counter = 0
				var new_enemy = load(str(i.enemy.resource_path))
				var counter = 0
				# while the counter is less than the SpawnInfo.enemy_number, instantiate it to create the Node, get a random position for that Node and then use add_child function to add it to the scene.
				while counter < i.enemy_number:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_viewport_position()
					add_child(enemy_spawn)
					counter += 1


func get_random_viewport_position():
	# Get the Viewport Rectangle size and randomly increase it by 1.1 or 1.4.  This is vpr.
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var top_left = Vector2(player.get_global_position().x - vpr.x/2, player.get_global_position().y - vpr.y/2)
	var top_right = Vector2(player.get_global_position().x + vpr.x/2, player.get_global_position().y - vpr.y/2)
	var bottom_left = Vector2(player.get_global_position().x - vpr.x/2, player.get_global_position().y + vpr.y/2)
	var bottom_right = Vector2(player.get_global_position().x + vpr.x/2, player.get_global_position().y + vpr.y/2)
	var position_side = ["up", "down", "left", "right"]
	var spawn_position1 = Vector2.ZERO
	var spawn_position2 = Vector2.ZERO
	
	match position_side:
		"up":
			spawn_position1 = top_left
			spawn_position2 = top_right
		"down":
			spawn_position1 = bottom_left
			spawn_position2 = bottom_right
		"left":
			spawn_position1 = top_left
			spawn_position2 = bottom_left
		"right":
			spawn_position1 = top_right
			spawn_position2 = bottom_right
	
	var x_spawn = randf_range(spawn_position1.x, spawn_position2.x)
	var y_spawn = randf_range(spawn_position1.y, spawn_position2.y)
	
	return Vector2(x_spawn, y_spawn)


func get_random_radius_position():
	pass
