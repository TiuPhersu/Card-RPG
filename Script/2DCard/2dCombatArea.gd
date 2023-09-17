extends Node3D

@onready var CARD_COMBAT_INTERFACE = get_node("CardCombatInterface")
@onready var COMBAT_AREA_CAMERA = get_node("2dCombatAreaCamera")

var SELECTED_CARD
var SELECTED_OBJECT

func _ready():
	CARD_COMBAT_INTERFACE.get_node("CardInterface").draw_multiple_cards_from_deck(7)

func _input(event):
	if event.is_action_released("leftclick"):
		# TODO: Check Collision then Play Card
		CARD_COMBAT_INTERFACE.get_node("CardInterface").play_card(SELECTED_CARD)
		SELECTED_OBJECT = COMBAT_AREA_CAMERA.get_selection(event.position)
#		print(SELECTED_OBJECT)
		
	if event.is_action_pressed("leftclick") || event.is_action_released("leftclick"):
		SELECTED_CARD = CARD_COMBAT_INTERFACE.get_node("CardInterface").get_card_in_hand(event.is_action_pressed("leftclick"), event.is_action_released("leftclick"))
#		print(SELECTED_CARD)
