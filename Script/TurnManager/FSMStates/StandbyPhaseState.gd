class_name StandbyPhaseState
extends State

@export var COMBAT_INTERFACE: Node2D

@onready var FSM: FiniteStateMachine

func _enter_state() -> void:
	print("Standby Phase!")
	_exit_state("MainPhaseState")
	pass

func _exit_state(next_state) -> void:
	print("End Standby")
	FSM.change_state(next_state)
	pass
