class_name MainPhaseState
extends State

@export var COMBAT_INTERFACE: Node2D
@export var COMBAT_AREA_CAMERA: Camera3D

@onready var CARD_INTERFACE = COMBAT_INTERFACE.get_node("CardInterface")
@onready var FSM: FiniteStateMachine

var SELECTED_CARD
var SELECTED_OBJECT

func _input(event):
	if event.is_action_released("rightclick"):
		SELECTED_OBJECT = COMBAT_AREA_CAMERA.get_selection(event.position) # Get the unit info
		if SELECTED_OBJECT != null && SELECTED_OBJECT["collider"].is_in_group("Playable"):
			COMBAT_INTERFACE.show_unit_info(SELECTED_OBJECT["collider"].UNIT_DATA)
	
	if event.is_action_released("leftclick"):
		# TODO: Check Collision then Play Card
		CARD_INTERFACE.play_card(SELECTED_CARD) # Play the card
		SELECTED_OBJECT = COMBAT_AREA_CAMERA.get_selection(event.position) # Get the unit info
	
	# Select the card from the hand
	if event.is_action_pressed("leftclick") || event.is_action_released("leftclick"):
		SELECTED_CARD = CARD_INTERFACE.get_card_in_hand(event.is_action_pressed("leftclick"), event.is_action_released("leftclick"))
		#print(SELECTED_CARD)
	
	if event.is_action_pressed("escape"):
		COMBAT_INTERFACE.close_unit_info()
	
	if event.is_action_pressed("enter"):
		end_main()

func _enter_state() -> void:
	print("Main Phase!")
	pass

func _exit_state(next_state) -> void:
	print("End Main Phase")
	FSM.change_state(next_state)
	pass

func end_main() -> void:
	_exit_state("EndPhaseState")
