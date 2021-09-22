extends KinematicBody2D

export(float) var TURN_SPEED = 4
export(float) var ACCEL = 75
export(float) var MAX_SPEED = 100
export(int) var maxHealth = 50

onready var jetSprite = $JetSprite
onready var health = maxHealth

signal health_changed(value)
signal i_just_died()

var isAlive = true
onready var deathTimer = $DeathTimer
onready var startPos = position

var bulletPrefab = preload("res://Player/Shot.tscn")
onready var shotPoint = $ShotPoint



var movement = Vector2.ZERO



func _physics_process(delta):
	if isAlive:
		handle_input(delta)
	


func handle_input(delta):
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
	
	if health > 0:
	#	emit_signal("health_changed", health / maxHealth)
		update_health(health - 50)
		return
	
	emit_signal("i_just_died")
	deathTimer.start()
	isAlive = false
	visible = false
	
	
func shoot():
	var newShot = bulletPrefab.instance()
	var facing = Vector2.UP.rotated(rotation)
	get_tree().get_root().get_node("World").add_child(newShot)
	newShot.position = shotPoint.global_position
	newShot.SetDirection(facing)


func _on_Button_pressed():
	reset_player()
	
func reset_player():
	rotation = 0
	movement = Vector2.ZERO
	position = startPos
	isAlive = true
	visible = true
	update_health(maxHealth)

func update_health(newHealth):
	health = newHealth
	emit_signal("health_changed", float (health) / float(maxHealth))

func _on_Player_i_just_died():
	pass # Replace with function body.
