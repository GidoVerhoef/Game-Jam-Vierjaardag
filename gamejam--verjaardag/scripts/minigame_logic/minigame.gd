extends Node2D

signal finished(result)

@onready var ui_root: Node2D = $"."
@onready var canvas_layer: CanvasLayer = $CanvasLayer

const DESIGN_SIZE := Vector2(1152, 648)

func resize_to_panel(panel: Control) -> void:
	var scale_factor: float = min(
		panel.size.x / DESIGN_SIZE.x,
		panel.size.y / DESIGN_SIZE.y
	)

	canvas_layer.scale = Vector2.ONE * scale_factor

	var scaled_size: Vector2 = DESIGN_SIZE * scale_factor
	canvas_layer.offset = panel.global_position + (panel.size - scaled_size) / 2

func start() -> void:
	print("Minigame started")


func finish(result) -> void:
	finished.emit(result)
