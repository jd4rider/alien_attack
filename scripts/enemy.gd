extends Area2D

signal died

@export var speed = 5

func _physics_process(delta):
	global_position.x += -speed * delta

func die():
	queue_free()
	died.emit()
	
func die_no_score():
	queue_free()
	
func _on_body_entered(body):
	body.take_damage()
	die_no_score()
