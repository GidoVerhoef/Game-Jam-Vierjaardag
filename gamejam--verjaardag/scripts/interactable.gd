class_name Interactable
extends Area2D

signal interacted(interactable: Interactable)

enum InteractionType {
	MINIGAME,
	DIALOGUE,
	PICKUP,
}

@export var interaction_type: InteractionType
@export var requires_movement := true
@export var minigame: String


func _ready() -> void:
	input_pickable = true
	add_to_group("interactables")


func _input_event(_viewport, event, _shape_idx) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("CLICKED ", name)
			interacted.emit(self)
