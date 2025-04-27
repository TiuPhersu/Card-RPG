extends Node
class_name FiniteStateMachine

@export var STATE: State

var states = {}

func _ready():
	get_all_states()
#	print(states)
	change_state(STATE.name)

func change_state(new_state):
	if new_state == null:
		return
	STATE = states[new_state]
	STATE._enter_state()

func get_all_states():
	for state in get_children():
		state.FSM = self
		states[state.name] = state

func _input(event: InputEvent) -> void:
#	print(str(event))
	STATE._handle_input(event)

func _process(delta) -> void:
	STATE._update(delta)
	
func _physics_process(delta) -> void:
	STATE._physics_update(delta)
