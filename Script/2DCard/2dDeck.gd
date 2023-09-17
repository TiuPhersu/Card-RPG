extends Node2D

var CARD_LIST: Array
var DECK: Array

@export var DECK_SIZE: int

@onready var DECK_COUNT = self.get_node("Label")
@onready var FILE_HELPER = file_helper.new()

func create_deck():
#	TODO: Get Deck Data from Database
	for i in DECK_SIZE:
		DECK.append(CARD_LIST[randi() % CARD_LIST.size()])
	DECK_COUNT.text = str(DECK.size())

func shuffle_cards_into_deck(cardList: Array):
	randomize()
	cardList.shuffle()
	DECK.append_array(cardList)
	DECK_COUNT.text = str(DECK.size())
	check_deck_has_cards()

func get_card_from_deck(cardLoc):
	if !check_deck_has_cards():
		#TODO: Reshuffle Discard Pile into the Deck
		return
	var drawnCard = DECK[cardLoc]
	return drawnCard

func remove_card_from_deck(cardLoc):
	DECK.remove_at(cardLoc)
	DECK_COUNT.text = str(DECK.size())
	check_deck_has_cards()

func check_deck_has_cards():
	if DECK.size() <= 0:
		self.get_node("DeckButton").disabled = true
		print("No Cards in the Deck")
		return false
	else:
		self.get_node("DeckButton").disabled = false
		return true

func _ready():
	CARD_LIST = FILE_HELPER.list_files_in_directory("res://Data/Cards/")
	create_deck()
