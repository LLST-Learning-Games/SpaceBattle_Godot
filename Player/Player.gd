extends KinematicBody2D

export(float) var TURN_SPEED = 4
export(float) var ACCEL = 75
export(float) var MAX_SPEED = 100
export(int) var maxHealth = 50

onready var jetSprite = $JetSprite
onready var health = maxHealth
signal health_changed(value)

var bulletPrefab = preload("res://Player/Shot.tscn")
onready var shotPoint = $ShotPoint

var movement = Vector2.ZERO

#func _onready():
#	var healthUI = get_node("../CanvasLayer/HealthUI")
#	self.connect("health_changed",healthUI,"UpdateBar")


func _physics_process(delta):
	var rotation = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * TURN_SPEED * delta
	self.rotation += rotation 
	
	var impulseInput = Input.get_action_strength("ui_up")
	var impulse = Vector2(0, impulseInput * -ACCEL * delta).rotated(self.rotation)
	jetSprite.scale.y = impulseInput
	movement += impulse
	if movement.length_squared() >= MAX_SPEED * MAX_SPEED:
		movement = movement.normalized() * MAX_SPEED
	
	var collision_info = move_and_collide(movement * delta)
	
	if collision_info:
		collide()
	
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func collide():
	emit_signal("health_changed", float (health) / float(maxHealth))
	if health > 0:
	#	emit_signal("health_changed", health / maxHealth)
		health -= 1
		return
	
	#queue_free()
	
func shoot():
	var newShot = bulletPrefab.instance()
	var facing = Vector2.UP.rotated(rotation)
	get_tree().get_root().get_node("World").add_child(newShot)
	newShot.position = shotPoint.global_position
	newShot.SetDirection(facing)
