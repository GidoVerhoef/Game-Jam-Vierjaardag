extends Node2D

var seq = []
var playerIndex = 0
var player = false
const binds = ["w", "a", "s", "d"]

func _ready() -> void:
	start_new_sequence()

func start_new_sequence():
	
	seq.append(randi() % 4)
	playerIndex = 0
	play_sequence()

func play_sequence():
	player = false
	for step in seq:
		print("key: ", binds[step])
		await get_tree().create_timer(0.75).timeout
		
	player = true
	
	
func _input(event: InputEvent) -> void:
	if not player:
		return
	for i in range(binds.size()):
		if event.is_action_pressed(binds[i]):
			check_input(i)

func check_input(pressed: int) -> void:
		if pressed == seq[playerIndex]:
			playerIndex += 1
			if playerIndex == seq.size():
				print("success")
				await get_tree().create_timer(1.5).timeout
				start_new_sequence()
		else:
			print("fail")
			seq.clear()
			start_new_sequence()
	
