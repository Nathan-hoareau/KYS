extends CharacterBody2D

#@export var texture = Texture
#@export var pos = Vector2
@onready var _animatedSprite = $Sprite2D

func _ready():
	_animatedSprite.scale = Vector2(.25, .25)
	_animatedSprite.play('idle')
#	$Sprite2D.position = pos

func _process(_delta):
	var direction = Vector2.ZERO

	if Input.is_action_just_pressed('ui_up'):
		direction.y -= 1
	elif Input.is_action_just_pressed('ui_down'):
		direction.y += 1
	elif Input.is_action_just_pressed('ui_right'):
		direction.x += 1
	elif Input.is_action_just_pressed('ui_left'):
		direction.x -= 1

	direction = direction.normalized() * 16
	move_and_collide(direction)
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
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
