class_name EndPhaseState
extends State

@export var COMBAT_INTERFACE: Node2D

@onready var CARD_INTERFACE = COMBAT_INTERFACE.get_node("CardInterface")
@onready var FSM: FiniteStateMachine

func _enter_state() -> void:
	print("End Phase!")
	CARD_INTERFACE.discard_hand()
	_exit_state("EnemyPhaseState")
	pass

func _exit_state(next_state) -> void:
	print("End End Phase")
	FSM.change_state(next_state)
	pass
