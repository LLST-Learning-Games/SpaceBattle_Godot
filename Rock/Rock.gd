extends KinematicBody2D

var rockScene = load("res://Rock/Rock.tscn")

var direction = Vector2.ZERO
var rot_speed = 0
export(int) var speed_min = 50
export(int) var speed_max = 100

enum {SMALL, MED, BIG}

onready var size = BIG
signal destroy_rock(mySize, myPos)

	
func _physics_process(delta):
	rotation += rot_speed * delta
	var collision_info = move_and_collide(direction * delta)
	
	if collision_info:
		collide()

func _on_LifeTimer_timeout():
	queue_free()

func collide():
	if size != SMALL:
		emit_signal("destroy_rock", size, position)
	queue_free()
	
func set_size(newSize):
	size = newSize
	
	var newScale = (newSize + 1) / 3.0
	
	scale.x = newScale
	scale.y = newScale
	
func set_speed(newDir):
	var speed = rand_range(speed_min, speed_max)
	direction = newDir.normalized() * speed
	
	rot_speed = (speed - (speed_max - speed_min / 2)) / 10
