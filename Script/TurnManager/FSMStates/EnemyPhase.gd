class_name EnemyPhaseState
extends State

@export var COMBAT_INTERFACE: Node2D

@onready var FSM: FiniteStateMachine

func _enter_state() -> void:
	print("Enemy Phase!")
	_exit_state("DrawPhaseState")
	pass

func _exit_state(next_state) -> void:
	print("End Enemy Phase")
	FSM.change_state(next_state)
	pass
