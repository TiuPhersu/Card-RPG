class_name DrawPhaseState
extends State

@export var COMBAT_INTERFACE: Node2D
@export var STARTING_HAND_COUNT: int = 5

@onready var CARD_INTERFACE = COMBAT_INTERFACE.get_node("CardInterface")
@onready var FSM: FiniteStateMachine

func _enter_state() -> void:
	print("Draw Phase!")
	CARD_INTERFACE.draw_multiple_cards_from_deck(STARTING_HAND_COUNT)
	_exit_state("StandbyPhaseState")
	pass

func _exit_state(next_state) -> void:
	print("End Draw")
	FSM.change_state(next_state)
	pass
