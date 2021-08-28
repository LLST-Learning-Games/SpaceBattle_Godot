extends KinematicBody2D

export(float) var TURN_SPEED = 2
export(float) var ACCEL = 50
export(float) var MAX_SPEED = 100

onready var jetSprite = $JetSprite

var movement = Vector2.ZERO


func _physics_process(delta):
	var rotation = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * TURN_SPEED * delta
	self.rotation += rotation 
	
	var impulseInput = Input.get_action_strength("ui_up")
	var impulse = Vector2(0, impulseInput * -ACCEL * delta).rotated(self.rotation)
	jetSprite.scale.y = impulseInput
	movement += impulse
	if movement.length_squared() >= MAX_SPEED * MAX_SPEED:
		movement = movement.normalized() * MAX_SPEED
	move_and_slide(movement)
	
