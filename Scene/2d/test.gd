extends Control

var SELECTED_CARD

func _ready():
	draw_hand()

func _input(event):
	if event.is_action_pressed("leftclick") || event.is_action_released("leftclick"):
		play_card(SELECTED_CARD)
		SELECTED_CARD = select_card(event.is_action_pressed("leftclick"), event.is_action_released("leftclick"))

func draw_hand():
	self.get_node("CardInterface").draw_multiple_cards_from_deck(7)

func select_card(pressed, released):
	var test = self.get_node("CardInterface").get_card_in_hand(pressed, released)
	print(test)
	SELECTED_CARD = test
	print(test)
	
func play_card(card):
	self.get_node("CardInterface").play_card(card)
