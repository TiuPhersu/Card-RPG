extends Node2D

@onready var HAND = get_node("HandNode");
@onready var DECK = get_node("DeckNode");

func get_card_in_hand(pressed, released):
	return HAND.focus_card_in_hand(pressed, released)

func draw_card_from_deck():
	var topCardLoc = DECK.DECK.size() - 1
	var drawnCard = DECK.get_card_from_deck(topCardLoc)
	var checkIfDrawn = HAND.create_card_from_database(drawnCard, DECK.position)
	if checkIfDrawn:
		DECK.remove_card_from_deck(topCardLoc)

func draw_multiple_cards_from_deck(numCards:int):
	var i: int = 0
	
#	TODO: Remove this after getting discard to deck reshuffle to work
	if DECK.DECK.size() <= 0:
		return
#	TODO: Remove this after getting discard to deck reshuffle to work
	if DECK.DECK.size() < numCards:
		numCards = DECK.DECK.size()
		
	while i < numCards:
		var topCardLoc = DECK.DECK.size() - 1
		var drawnCard = DECK.get_card_from_deck(topCardLoc)
		var checkIfDrawn = HAND.create_card_from_database(drawnCard, DECK.position)
		if checkIfDrawn:
			i = i + 1
			DECK.remove_card_from_deck(topCardLoc)
			await get_tree().create_timer(0.15).timeout

# TODO: SHOW DECKLIST INSTEAD OF DRAWING CARD
func _on_deck_button_pressed():
	draw_card_from_deck()
