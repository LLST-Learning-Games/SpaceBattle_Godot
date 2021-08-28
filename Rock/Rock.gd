extends KinematicBody2D

var direction = Vector2.ZERO
export(int) var speed_min = 50
export(int) var speed_max = 100

enum {NORTH, WEST, SOUTH, EAST}

# Called when the node enters the scene tree for the first time.
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

func _physics_process(delta):
	move_and_collide(direction * delta)


func _on_LifeTimer_timeout():
	queue_free()
