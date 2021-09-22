extends ProgressBar

onready var timer = $Timer

func _ready():
	self.set_max(timer.wait_time) 
	timer.start()
	
func _process(delta):
	self.value = timer.time_left


func _on_Timer_timeout():
	print("You win!")



func _on_Player_i_just_died():
	timer.paused = true


func _on_DeathButton_pressed():
	timer.paused = false
	timer.start()
