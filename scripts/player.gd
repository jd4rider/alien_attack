extends CharacterBody2D

signal took_damage

@export var speed = 300

@export var lives = 3

var rocket_scene = preload("res://scenes/rocket.tscn")

@onready var rocket_container = $RocketContainer

@onready var rocket_shot = $RocketShot

func _physics_process(delta):
	velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("right"):
		velocity.x = speed
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	if Input.is_action_pressed("down"):
		velocity.y = speed
		
	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
func shoot():
	rocket_shot.play() 
	var rocket = rocket_scene.instantiate()
	rocket_container.add_child(rocket)
	rocket.global_position = global_position
	rocket.global_position.x += 80
	

	
	global_position = global_position.clamp(Vector2(0,0), get_viewport_rect().size)
	
func take_damage():
	took_damage.emit()
	
func die():
	queue_free()
