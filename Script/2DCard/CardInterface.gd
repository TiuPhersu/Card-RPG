extends Node2D

@onready var HAND = get_node("HandNode");
@onready var DECK = get_node("DeckNode");

func _input(event):
	if Input.is_action_just_released("leftclick"):
		var drawnCard = DECK.draw_card_from_deck()
		HAND.create_card_from_database(drawnCard, DECK.position)
