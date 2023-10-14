extends Node
class_name State

signal state_finished

func _enter_state() -> void:
	pass
	
func _exit_state(_next_state) -> void:
	pass

func _handle_input(_event) -> void:
	pass

func _update(_delta) -> void:
	pass

func _physics_update(_delta) -> void:
	pass
