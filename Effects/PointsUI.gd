extends Label


var destroyed = 0
var high_score = 0
onready var hsLabel = $HSLabel

func _count_destroyed(a,b):
	destroyed += 1
	text = str(destroyed)
	
	if hsLabel.visible == true && destroyed > high_score:
		high_score = destroyed
		hsLabel.text = str(high_score)


func _on_DeathButton_pressed():
	hsLabel.visible = false
	destroyed = 0	
	
	text = str(destroyed)


func _on_Player_i_just_died():
	hsLabel.visible = true
	
