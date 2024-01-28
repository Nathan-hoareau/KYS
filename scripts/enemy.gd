extends CharacterBody2D

@export var type: String

var speed = 90
var player_chase = false
var player = null;

func _ready():
	match type:
		'Dragon':
			$Dragon.show()
			$Dragon.play('front')
		'Slime':
			$Slime.show()
			$Slime.play('front')
	pass

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed


func _on_detection_box_body_entered(body):
	player = body
	player_chase = true


func _on_detection_box_body_exited(body):
	player = null
	player_chase = false


#func _process(delta):
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
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

