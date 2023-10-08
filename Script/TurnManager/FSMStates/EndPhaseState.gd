class_name EndPhaseState
extends State

@export var COMBAT_INTERFACE: Control

@onready var FSM: FiniteStateMachine

func _enter_state() -> void:
	print("End Phase!")
	_exit_state("EnemyPhaseState")
	pass

func _exit_state(next_state) -> void:
	print("End End Phase")
	FSM.change_state(next_state)
	pass
