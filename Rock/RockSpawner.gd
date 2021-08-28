extends Node

export(int) var MAX_X = 320
export(int) var MAX_Y = 180
enum {NORTH, WEST, SOUTH, EAST}
var startWall = NORTH
var spawnPoint = Vector2.ZERO
var rockPrefab = preload("res://Rock/Rock.tscn")


func _ready():
	randomize()
	
func generate_spawn_point():
	#first decide if it which wall it will spawn on
	startWall = randi() % 5
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
	
	print (spawnPoint)
	return spawnPoint


func _on_Timer_timeout():
	var newRock = rockPrefab.instance()
	add_child(newRock)
	newRock.generateDirection(startWall)
	newRock.position = generate_spawn_point()
