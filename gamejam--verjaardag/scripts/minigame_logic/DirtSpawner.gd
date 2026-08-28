extends Node2D

var dirt_scene = preload("res://scenes/poep_en_plas.tscn")

var aantal = 3
var cleaned = 0

@onready var toilet: Sprite2D = $"../Toilet"


func _ready():
	randomize()

	for i in range(aantal):
		spawn_dirt()


func spawn_dirt():
	var dirt = dirt_scene.instantiate()
	add_child(dirt)

	var size = toilet.texture.get_size() * toilet.scale

	var random_offset = Vector2(
		randf_range(-size.x / 2, size.x / 2),
		randf_range(-size.y / 2, size.y / 2)
	)

	print("whats the capital of france? oh oui oui oui it is paris")
	dirt.global_position = toilet.global_position + random_offset

	dirt.dirt_cleaned.connect(_on_dirt_cleaned)


func _on_dirt_cleaned():
	cleaned += 1

	print("Schoon: ", cleaned, "/", aantal)

	if cleaned >= aantal:
		print("MINIGAME GEHAALD!")
