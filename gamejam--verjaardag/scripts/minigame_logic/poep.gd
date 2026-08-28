extends Area2D

signal dirt_cleaned

var cleaner_inside := false
var opacity := 1.0
var can_clean := true

@export var min_swipe_speed: float = 1000.0 

var last_mouse_pos := Vector2.ZERO

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	last_mouse_pos = get_global_mouse_position()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		cleaner_inside = true


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		cleaner_inside = false


func _process(delta: float) -> void:
	var current_pos = get_global_mouse_position()
	
	if delta > 0:
		var current_mouse_speed = current_pos.distance_to(last_mouse_pos) / delta
		
		if cleaner_inside and current_mouse_speed >= min_swipe_speed and can_clean:
			clean()
	
	last_mouse_pos = current_pos


func clean() -> void:
	can_clean = false

	opacity -= 0.15
	sprite.modulate.a = opacity

	if opacity <= 0:
		dirt_cleaned.emit()
		queue_free()
		return

	await get_tree().create_timer(0.05).timeout
	can_clean = true
