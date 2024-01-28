extends Area2D

var dialogue = DialogueResource

func action() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, 'start')
