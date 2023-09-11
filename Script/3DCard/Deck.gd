extends Node3D

const CARD = preload("res://Scene/3d/Card.tscn")
var card_counter_fun: int = 0

func load_data():
	print("loading data")

func create_deck():
	for _x in 25:
		var card = CARD.instantiate()
		card_counter_fun += 1
		card.get_node("Card").get_node("Title").text = "test " + str(card_counter_fun)
		card.hide()
		add_child(card)
	print(self.get_child_count(false))
	print("created deck")
	# Pull data on the deck and store that data somewhere

func draw_cards():
	# pull top card in the deck
	# Create the cards
	# Send the cards to the hand
	print("drawing a card from the deck")
	
	var deckCount = self.get_child_count(false)
	print(deckCount)
	
	if deckCount > 0:
		var topCard = self.get_child(0)
		topCard.show()
		self.remove_child(topCard)
		return(topCard)
	else:
		print("Out of Cards")
		# TODO Reshuffle Discard Pile Back into Deck then draw
		return(null)

func _ready():
	print("ready")
	create_deck()
