extends Node2D

var seq = []
var playerIndex = 0
var player = false

var winstreak = 0

const binds = [KEY_W, KEY_A, KEY_S, KEY_D]

@onready var texture_rect_2: TextureRect = $"../Control/TextureRect2"
@onready var label: Label = $"../Control/TextureRect2/Label"
@onready var answer_label: Label = $"../Control/AnswerLabel"
@onready var simon_says_minigame: Node2D = $"../.."


func _ready() -> void:
	start_new_sequence()


func start_new_sequence():
	seq.append(randi() % 4)
	playerIndex = 0
	answer_label.text = ""
	answer_label.modulate = Color.WHITE
	play_sequence()


func play_sequence():
	player = false
	texture_rect_2.modulate = Color("#979797")

	for step in seq:
		label.text = OS.get_keycode_string(binds[step])
		texture_rect_2.modulate = Color("#ffffff")

		await get_tree().create_timer(0.4).timeout

		texture_rect_2.modulate = Color("#979797")
		label.text = ""

		await get_tree().create_timer(0.35).timeout

	player = true


func _input(event: InputEvent) -> void:
	if not player or not event is InputEventKey:
		return
	if not event.pressed or event.echo:
		return

	var pressed = binds.find(event.keycode)
	if pressed != -1:
		check_input(pressed)


func check_input(pressed: int) -> void:
	if playerIndex >= seq.size():
		return

	answer_label.text += OS.get_keycode_string(binds[pressed]) + " "

	if pressed == seq[playerIndex]:
		playerIndex += 1

		if playerIndex == seq.size():
			print("success")
			player = false
			winstreak += 1
			await get_tree().create_timer(1).timeout
			if winstreak == 4:
				simon_says_minigame.finish(true)
			start_new_sequence()
	else:
		print("fail")
		player = false
		answer_label.modulate = Color.RED
		await get_tree().create_timer(0.5).timeout
		
		seq.clear()
		simon_says_minigame.finish(false)
