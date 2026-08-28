extends Node2D

# Called when the node enters the scene tree for the first time.
# Interactable nodes need to be added here to register then as interactable
func _ready() -> void:
	$Tilemap/Player/InteractionManager.register_interactable($Tilemap/Stage/Interactable)
	$Tilemap/Player/InteractionManager.register_interactable($Tilemap/Toilet/Interactable)
	MinigameManager.setup($CanvasLayer/Control_minigame)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
