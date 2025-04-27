class_name StartState
extends State

@export var COMBAT_INTERFACE: Node2D
@export var DRAW_CARD_COUNT:int = 5

@onready var CARD_INTERFACE = COMBAT_INTERFACE.get_node("CardInterface")
@onready var FSM: FiniteStateMachine

func _enter_state() -> void:
	print("Starting!")
	CARD_INTERFACE.draw_multiple_cards_from_deck(DRAW_CARD_COUNT)
	_exit_state("StandbyPhaseState")

func _exit_state(next_state) -> void:
	print("Start Completed")
	FSM.change_state(next_state)
	pass
