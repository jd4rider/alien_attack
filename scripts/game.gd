extends Node2D

@export var lives = 3
var score = 0

@onready var player = $Player

@onready var hud = $UI/HUD

@onready var UI = $UI

@onready var enemy_hit_sound = $EnemyHitSound

@onready var player_hit_sound = $PlayerHitSound

var game_over_screen = preload("res://scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_lives_label(lives)

func _on_player_took_damage():
	lives -= 1
	hud.set_lives_label(lives)
	player_hit_sound.play()
	if lives == 0:
		player.die()
		await get_tree().create_timer(1.5).timeout
		spawn_game_over()


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	add_child(enemy_instance)
	enemy_instance.died.connect(enemy_died)

func enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()
	
func spawn_game_over():
	var game_over_instance = game_over_screen.instantiate()
	game_over_instance.set_score(score)
	UI.add_child(game_over_instance)


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.died.connect(enemy_died)
