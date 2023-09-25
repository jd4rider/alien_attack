extends Node2D

signal enemy_spawned(enemy_instance)

signal path_enemy_spawned(path_enemy_instance)

var enemy_scene = preload("res://scenes/enemy.tscn")

var path_enemy = preload("res://scenes/path_enemy.tscn")

@onready var spawn_positions = $SpawnPositions


func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var spawn_postions_array = spawn_positions.get_children()
	
	var enemy_instance = enemy_scene.instantiate()

	enemy_spawned.emit(enemy_instance)
	enemy_instance.global_position = spawn_postions_array.pick_random().global_position


func _on_path_enemy_timer_timeout():
	spawn_path_enemy()
	
func spawn_path_enemy():
	var path_enemy_instance = path_enemy.instantiate()
	path_enemy_spawned.emit(path_enemy_instance)
	
	
