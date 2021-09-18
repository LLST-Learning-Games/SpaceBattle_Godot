extends AnimatedSprite


func _ready():
	self.connect("animation_finished", self, "_on_Explosion_animation_finished")
	
	self.speed_scale = rand_range(0.8,1.5)
#	frame = 0
	play("Explosion")
	
	
func _on_Explosion_animation_finished():
	queue_free()
