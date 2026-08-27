extends Node

var current_minigame: Node = null
var minigame_container: Control

@export var minigame_scenes: Dictionary = {
	"minigame": preload("res://scenes/minigame.tscn")
}


func setup(container: Control) -> void:
	minigame_container = container

func is_minigame_active() -> bool:
	return current_minigame != null

func start_minigame(minigame_id: String) -> void:
	if minigame_container == null:
		push_error("Minigame container hasn't been set up.")
		return

	if current_minigame != null:
		push_warning("A minigame is already running.")
		return

	if not minigame_scenes.has(minigame_id):
		push_error("Unknown minigame: " + minigame_id)
		return

	var scene: PackedScene = minigame_scenes[minigame_id]
	current_minigame = scene.instantiate()

	minigame_container.add_child(current_minigame)

	current_minigame.resize_to_panel(minigame_container)

	get_tree().paused = true
	current_minigame.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	current_minigame.finished.connect(_on_minigame_finished)
	current_minigame.start()

	minigame_container.show()


func _on_minigame_finished(result) -> void:
	print("Minigame finished: ", result)
	stop_minigame()


func stop_minigame() -> void:
	if current_minigame == null:
		return

	current_minigame.queue_free()
	current_minigame = null

	minigame_container.hide()
	get_tree().paused = false
