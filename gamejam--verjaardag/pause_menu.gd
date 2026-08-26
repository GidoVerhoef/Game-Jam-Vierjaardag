extends Node2D


# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_pause_button_pressed()

func _on_pause_button_pressed():
	show()
	get_tree().paused = true

func _on_button_pressed() -> void:
	hide()
	get_tree().paused = false
