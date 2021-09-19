extends ProgressBar

#func _onready():
#	var player = get_tree().get_root().get_node("Player")
#	self.connect("health_changed",player,"_update_bar")

#func _update_bar(value):
	


func _on_Player_health_changed(value):
	self.value = value * 100
	print("ouch! " + str(value))
