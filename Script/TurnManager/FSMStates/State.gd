extends Node
class_name State

signal state_finished

func _enter_state() -> void:
	pass
	
func _exit_state(next_state) -> void:
	pass

func _handle_input(event) -> void:
	pass

func _update(delta) -> void:
	pass

func _physics_update(delta) -> void:
	pass
