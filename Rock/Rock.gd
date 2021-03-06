extends KinematicBody2D

var explosionFX = preload("res://Effects/Explosion.tscn")

var direction = Vector2.ZERO
var rot_speed = 0
export(int) var speed_min = 50
export(int) var speed_max = 100

enum {SMALL, MED, BIG}

onready var size = BIG
var spawn_invincible = true
signal destroy_rock(mySize, myPos)

	
func _physics_process(delta):
	rotation += rot_speed * delta
	var collision_info = move_and_collide(direction * delta)
	
	if collision_info && !spawn_invincible:
		collide()

func _on_LifeTimer_timeout():
	queue_free()

func collide():
	
	emit_signal("destroy_rock", size, position)
	
	var newExplFX = explosionFX.instance()
	get_parent().add_child(newExplFX)
	newExplFX.position = position
	newExplFX.rotation = rotation
	
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


func _on_CollisionTimer_timeout():
	spawn_invincible = false
