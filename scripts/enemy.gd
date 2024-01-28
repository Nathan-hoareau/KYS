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

func _physics_process(_delta):
	if player_chase:
		position += (player.position - position) / speed


func _on_detection_box_body_entered(body):
	player = body
	player_chase = true


func _on_detection_box_body_exited(_body):
	player = null
	player_chase = false
