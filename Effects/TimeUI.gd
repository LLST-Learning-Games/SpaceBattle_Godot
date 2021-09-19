extends ProgressBar

onready var timer = $Timer

func _ready():
	self.set_max(timer.wait_time) 
	timer.start()
	
func _process(delta):
	self.value = timer.time_left


func _on_Timer_timeout():
	print("You win!")

