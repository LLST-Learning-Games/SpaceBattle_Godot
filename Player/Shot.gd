extends KinematicBody2D

var explosionFX = preload("res://Effects/Explosion.tscn")

export(float) var spin_speed = 10

export(float) var move_speed = 300

var direction = Vector2.UP




func _process(delta):
	rotation += spin_speed * delta
	var collide = move_and_slide(direction * move_speed)
	
	#if collide:
	#	queue_free()
	
func SetDirection(newDir):
	direction = newDir.normalized()


func _on_DeathTimer_timeout():
	var newExplFX = explosionFX.instance()
	get_parent().add_child(newExplFX)
	newExplFX.position = position
	newExplFX.rotation = rotation
	newExplFX.scale = Vector2(.1,.1)
	queue_free()
