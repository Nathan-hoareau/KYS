extends ProgressBar

@export var player: CharacterBody2D
var sb = StyleBoxFlat.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	player.gainedHealth.connect(update)
	player.reduceHealth.connect(update)
	add_theme_stylebox_override("fill", sb)
	pass # Replace with function body.

func update():
	value = player.currentHealth
	if value > 75:
		sb.bg_color = Color("00ff00")
	if value < 75 && value > 50:
		sb.bg_color = Color("fcf003")
	if value < 50 && value > 15:
		sb.bg_color = Color("ff0000")
	if value < 15:
		sb.bg_color = Color("000000")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
