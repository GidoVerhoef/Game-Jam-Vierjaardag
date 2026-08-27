class_name InteractionHandler
extends Node

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("interactables"):
		if node is Interactable:
			register_interactable(node)


func register_interactable(interactable: Interactable) -> void:
	if interactable == null:
		return

	interactable.interacted.connect(_on_interacted)


func _on_interacted(interactable: Interactable) -> void:
	print("HANDLER RECEIVED: ", interactable.name)
	print("TYPE: ", interactable.interaction_type)
	
	perform_interaction(interactable)


func perform_interaction(interactable: Interactable) -> void:
	match interactable.interaction_type:
		Interactable.InteractionType.MINIGAME:
			MinigameManager.start_minigame(interactable.minigame)

		Interactable.InteractionType.DIALOGUE:
			print("Start dialogue")

		Interactable.InteractionType.PICKUP:
			print("Pick up item")

		_:
			push_warning("Unknown interaction type")
