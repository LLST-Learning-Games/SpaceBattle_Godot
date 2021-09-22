extends Node

export(int) var MAX_X = 640
export(int) var MAX_Y = 360

enum {NORTH, WEST, SOUTH, EAST}
enum {SMALL, MED, BIG}

var startWall = NORTH
var spawnPoint = Vector2.ZERO
var rockPrefab = preload("res://Rock/Rock.tscn")

onready var timer = $Timer


func _ready():
	randomize()
	
func generate_spawn_point():
	#first decide if it which wall it will spawn on
	startWall = randi() % 4
	#startWall = NORTH
	match startWall:
		NORTH:
			spawnPoint.x = rand_range(0, MAX_X)
			spawnPoint.y = 0
		WEST:
			spawnPoint.x = 0
			spawnPoint.y = rand_range(0, MAX_Y)
		SOUTH:
			spawnPoint.x = rand_range(0, MAX_X)
			spawnPoint.y = MAX_Y
		EAST:
			spawnPoint.x = MAX_X
			spawnPoint.y = rand_range(0, MAX_Y)
	
	# print (startWall)
	# print (spawnPoint)
	return spawnPoint


func _on_Timer_timeout():
	createNewRock(BIG, generate_spawn_point(),generateDirection(startWall))


func _on_Rock_destroy_rock(mySize, myPos):
	# print ("rock destroyed")
	if mySize != SMALL:
		for i in rand_range(1,3):
			var randDirection = Vector2(rand_range(-1,1),rand_range(-1,1))
			createNewRock(mySize - 1, myPos + randDirection * 20, randDirection)
	
func createNewRock(spawnSize, spawnPosition, spawnDirection):
	var newRock = rockPrefab.instance()
	add_child(newRock)
	newRock.connect("destroy_rock", self, "_on_Rock_destroy_rock")
	newRock.connect("destroy_rock",get_node("../CanvasLayer/PointsUI"),"_count_destroyed")
	newRock.position = spawnPosition
	newRock.set_size(spawnSize)
	newRock.set_speed(spawnDirection)
	
func generateDirection(startWall):
	var direction = Vector2.ZERO
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
	return direction


func _on_Player_i_just_died():
	timer.stop()


func _on_DeathButton_pressed():
	timer.start()
