extends Node2D

@onready var HAND = get_node("HandNode");
@onready var DECK = get_node("DeckNode");

func draw_card_from_deck():
	var topCardLoc = DECK.DECK.size() - 1
	var drawnCard = DECK.get_card_from_deck(topCardLoc)
	var checkIfDrawn = HAND.create_card_from_database(drawnCard, DECK.position)
	if checkIfDrawn:
		DECK.remove_card_from_deck(topCardLoc)

func _on_deck_button_pressed():
	draw_card_from_deck()

