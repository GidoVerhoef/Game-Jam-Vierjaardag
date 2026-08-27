extends Button

#this is how you stop a minigame from playing
func _on_pressed() -> void:
	MinigameManager.stop_minigame()
