extends RigidBody2D

var rockScene = load("res://Rock/Rock.tscn")

var direction = Vector2.ZERO
export(int) var speed_min = 50
export(int) var speed_max = 100

enum {NORTH, WEST, SOUTH, EAST}
enum {SMALL, MED, BIG}

onready var size = BIG
signal destroy_rock(mySize)

# This should probably be moved to RockSpawner at some point
func generateDirection(startWall):
	match startWall:
		NORTH:
			direction.x = rand_range(-1, 1)
			direction.y = 1 #rand_range(0,1)
		WEST:
			direction.x = 1 # rand_range(0, 1)
			direction.y = rand_range(-1,1)
		SOUTH:
			direction.x = rand_range(-1, 1)
			direction.y = -1 # rand_range(-1,0)
		EAST:
			direction.x = -1 # rand_range(-1, 0)
			direction.y = rand_range(-1,1)
	
	
	var speed = rand_range(speed_min, speed_max)
	
	direction = direction.normalized() * speed
	apply_impulse(Vector2(), direction)
	


func _on_LifeTimer_timeout():
	queue_free()


func _on_Rock_body_entered(body):
	if size != SMALL:
		emit_signal("destroy_rock", size)
	queue_free()
	
	
	
