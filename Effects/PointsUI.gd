extends Label


var destroyed = 0


func _count_destroyed(a,b):
	destroyed += 1
	text = str(destroyed)
