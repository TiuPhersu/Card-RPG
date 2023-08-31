extends Control

@onready var HAND = get_node("CardInterface/HandNode");
@onready var DECK = get_node("CardInterface/DeckNode");

func _input(event):
	if Input.is_action_just_released("leftclick"):
		var drawnCard = DECK.draw_card_from_deck()
		HAND.create_card_from_database(drawnCard)
