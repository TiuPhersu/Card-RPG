extends Node2D

@onready var HAND = get_node("HandNode");
@onready var DECK = get_node("DeckNode");
@onready var DISCARD = get_node("DiscardNode");

var SELECTED_CARD;

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#print(event)
		#if event.pressed and event.button_index == 1:
			#SELECTED_CARD = get_card_in_hand(true, false)
			#print(SELECTED_CARD)
		#if event.pressed == false and event.button_index == 1:
			#play_card(SELECTED_CARD)
			#SELECTED_CARD = get_card_in_hand(false, true)
			#print(SELECTED_CARD)
	

func get_card_in_hand(pressed, released):
	var selectedFromHand = HAND.focus_card_in_hand(pressed, released)
	SELECTED_CARD = selectedFromHand 
	if SELECTED_CARD != null:
		print(SELECTED_CARD)
	return selectedFromHand

func draw_card_from_deck():
	if !DECK.check_deck_has_cards():
		shuffle_discard_to_deck()
	var topCardLoc = DECK.DECK.size() - 1
	var drawnCard = DECK.get_card_from_deck(topCardLoc)
	var checkIfDrawn = HAND.create_card_from_database(drawnCard, DECK.position)
	if checkIfDrawn:
		DECK.remove_card_from_deck(topCardLoc)

func shuffle_discard_to_deck():
	print("Shuffle")
	var allDiscard = DISCARD.get_all_card_from_discard()
	if allDiscard == null:
		return
	DECK.shuffle_cards_into_deck(allDiscard)
	DISCARD.clear_discard_pile()

func draw_multiple_cards_from_deck(numCards:int):
	var i: int = 0

	if DECK.DECK.size() <= 0:
		shuffle_discard_to_deck()
		
	while i < numCards:
		if !DECK.check_deck_has_cards():
			shuffle_discard_to_deck()
			
		var topCardLoc = DECK.DECK.size() - 1
		var drawnCard = DECK.get_card_from_deck(topCardLoc)
		if drawnCard == null:
			i = i + 1
			continue
		get_tree().get_root().set_disable_input(true)
		var checkIfDrawn = HAND.create_card_from_database(drawnCard, DECK.position)
		if checkIfDrawn:
			i = i + 1
			DECK.remove_card_from_deck(topCardLoc)
			await get_tree().create_timer(0.15).timeout
	get_tree().get_root().set_disable_input(false)

func play_card(card):
	if card == null:
		return
	if !card.IN_HAND_AREA and card.IN_PLAY_AREA:
		HAND.remove_card_from_hand(card)
	#	print(card.TITLE)
		DISCARD.put_card_to_discard(card.TITLE)

func discard_hand():
	for card in HAND.get_children(false):
		DISCARD.put_card_to_discard(card.TITLE)
		HAND.remove_card_from_hand(card)

# TODO: SHOW DECKLIST INSTEAD OF DRAWING CARD
func _on_deck_button_pressed() -> void:
	draw_card_from_deck()

# TODO: SHOW DISCARDPILE INSTEAD OF SHUFFLING DISCARD PILE INTO DECK
func _on_discard_button_pressed() -> void:
	shuffle_discard_to_deck()
