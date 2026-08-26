extends Node2D

@onready var ui_root: CanvasLayer = $CanvasLayer

const DESIGN_SIZE := Vector2(1152, 648)


func resize_to_panel(panel: Control) -> void:
	var panel_size = panel.size

	var scale_factor = min(
		panel_size.x / DESIGN_SIZE.x,
		panel_size.y / DESIGN_SIZE.y
	)

	ui_root.scale = Vector2.ONE * scale_factor
