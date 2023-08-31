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
		print(DECK[i])
	DECK_COUNT.text = str(DECK.size())

func draw_card_from_deck():
	if DECK.size() <= 0:
		print("Outta Cards")
		return
	var drawnCard = DECK[DECK.size()-1]
	DECK.remove_at(DECK.size()-1)
	DECK_COUNT.text = str(DECK.size())
	return drawnCard

func _ready():
	CARD_LIST = FILE_HELPER.list_files_in_directory("res://Data/Cards/")
	create_deck()
