extends KinematicBody2D

signal hit

const ACCELERATION = 50
const UP = Vector2(0,-1)
const GRAVITY = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

var motion = Vector2()
var direction = 1

func die():
	queue_free()

func _on_EnemyDetector_body_entered():
	var bodies = $EnemyDetector.get_overlapping_bodies()
	for body in bodies:
		if body.name == "Enemy":
			die()

#Controls/Movement/Abilities
func _physics_process(_delta):
	
	# Gravity
	motion.y += GRAVITY
	#Controls
	var left_button_pressed = Input.is_action_pressed("ui_left")
	var right_button_pressed = Input.is_action_pressed("ui_right")
	var up_button_pressed = Input.is_action_pressed("ui_up")
	# Movement for Controls
	if right_button_pressed:
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
	elif left_button_pressed:
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
	else: # Set motion to 0 if standing still
		motion.x = 0
	
	# Jump 
	if is_on_floor():
		if up_button_pressed:
			motion.y = JUMP_HEIGHT
	# Wall Jump
	if is_on_wall():
		if Input.is_action_just_pressed("ui_up"):
			
			if $RightWallDetect.is_colliding():
				motion.y = -550
				motion.x = -550
			if $LeftWallDectect.is_colliding():
				motion.y = -550
				motion.x = 550
	motion = move_and_slide(motion, UP)























