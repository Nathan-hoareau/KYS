extends CharacterBody2D

#@export var texture = Texture
#@export var pos = Vector2
@onready var _animatedSprite = $Sprite2D
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

signal gainedHealth
signal reduceHealth

var maxHealth = 100
var currentHealth = 50

func _unhandled_input(_event: InputEvent) -> void:
	pass
	# Only the balloon is allowed to handle input while it's showing
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return

func _ready():
	gainedHealth.emit()
	scale = Vector2(.25, .25)
	_animatedSprite.play('idle')
#	$Sprite2D.position = pos

func _process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed('ui_up'):
		direction.y -= 1
	elif Input.is_action_pressed('ui_down'):
		direction.y += 1
	elif Input.is_action_pressed('ui_right'):
		direction.x += 1
	elif Input.is_action_pressed('ui_left'):
		direction.x -= 1
#	elif Input.is_action_just_pressed('ui_accept'):
#		currentHealth += 5
#		gainedHealth.emit()
#	elif Input.is_action_just_pressed('ui_cancel'):
#		currentHealth -= 1
#		reduceHealth.emit()

	currentHealth += Answers.point
	gainedHealth.emit()
	Answers.point = 0
	direction = direction.normalized() * (delta + .5)
	move_and_collide(direction)
