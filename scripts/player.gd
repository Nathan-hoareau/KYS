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

func _process(delta):
	
	if currentHealth <= 0:
		get_tree().change_scene_to_file("res://scenes/gameOver.tscn")
		
	if currentHealth >= 100:
		get_tree().change_scene_to_file("res://scenes/youWin.tscn")
	
	var direction = Vector2.ZERO

	if Input.is_action_pressed('ui_up'):
		direction.y -= 1
		_animatedSprite.play("walk_back")
	elif Input.is_action_pressed('ui_down'):
		direction.y += 1
		_animatedSprite.play("walk_front")
	elif Input.is_action_pressed('ui_right'):
		direction.x += 1
		_animatedSprite.play("walk_right")
	elif Input.is_action_pressed('ui_left'):
		direction.x -= 1
		_animatedSprite.play("walk_left")

	currentHealth += Answers.point
	gainedHealth.emit()
	Answers.point = 0
	if direction.x == 0 and direction.y == 0:
		_animatedSprite.play("idle")
	direction = direction.normalized() * (delta + 0.65)
	move_and_collide(direction)

func _on_hitbox_body_entered(_body):
	currentHealth -= 10
	reduceHealth.emit()
	$Timer.start()
	pass # Replace with function body.

func _on_hitbox_body_exited(_body):
	$Timer.stop()
	pass # Replace with function body.

func _on_timer_timeout():
	currentHealth -= 10
	reduceHealth.emit()
	pass # Replace with function body.

