extends CharacterBody2D

#@export var texture = Texture
#@export var pos = Vector2
@onready var _animatedSprite = $Sprite2D

signal gainedHealth
signal reduceHealth

var maxHealth = 100
var currentHealth = 50

func _ready():
	scale = Vector2(.25, .25)
	_animatedSprite.play('idle')

func _process(delta):
	
	if currentHealth <= 0:
		get_tree().change_scene_to_file("res://scenes/gameOver.tscn")
		
	if currentHealth >= 100:
		get_tree().change_scene_to_file("res://scenes/youWin.tscn")
	
	var direction = Vector2.ZERO

	if Input.is_action_pressed('ui_up'):
		direction.y -= 1
	elif Input.is_action_pressed('ui_down'):
		direction.y += 1
	elif Input.is_action_pressed('ui_right'):
		direction.x += 1
	elif Input.is_action_pressed('ui_left'):
		direction.x -= 1
	elif Input.is_action_just_pressed('ui_accept'):
		currentHealth += 5
		gainedHealth.emit()
	elif Input.is_action_just_pressed('ui_text_backspace'):
		currentHealth -= 5
		reduceHealth.emit()
	direction = direction.normalized() * (delta + .5)
	move_and_collide(direction)

func _on_hitbox_body_entered(body):
	print("enemy in box, starting timer")
	$Timer.start()
	pass # Replace with function body.

func _on_hitbox_body_exited(body):
	print("enemy exited, stopping timer")
	$Timer.stop()
	pass # Replace with function body.

func _on_timer_timeout():
	print("timer timeout")
	currentHealth -= 10
	reduceHealth.emit()
	pass # Replace with function body.


## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()




