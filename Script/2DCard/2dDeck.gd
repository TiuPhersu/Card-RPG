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

func get_card_from_deck(cardLoc):
	if DECK.size() <= 0:
		#TODO: Reshuffle Discard Pile into the Deck
		self.get_node("DeckButton").disabled = true
		print("Outta Cards")
		return
	var drawnCard = DECK[cardLoc]
	return drawnCard

func remove_card_from_deck(cardLoc):
	DECK.remove_at(cardLoc)
	DECK_COUNT.text = str(DECK.size())
	if DECK.size() <= 0:
		self.get_node("DeckButton").disabled = true

func _ready():
	CARD_LIST = FILE_HELPER.list_files_in_directory("res://Data/Cards/")
	create_deck()
