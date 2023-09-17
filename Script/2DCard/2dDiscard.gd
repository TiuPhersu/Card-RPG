extends Node2D

var CARD_LIST: Array
var DISCARD: Array

@onready var DISCARD_COUNT = self.get_node("Label")
@onready var FILE_HELPER = file_helper.new()

func put_card_to_discard(cardName):
#	print(str(cardName)+".tres")
	var index = CARD_LIST.find(str(cardName)+".tres",0)
#	print(index)
	DISCARD.append(CARD_LIST[index])
	DISCARD_COUNT.text = str(DISCARD.size())
	check_discard_has_cards()

func get_card_from_discard(cardLoc):
	if !check_discard_has_cards():
		return
	var drawnCard = DISCARD[cardLoc]
	return drawnCard

func get_all_card_from_discard():
	if !check_discard_has_cards():
		return
	return DISCARD

func remove_card_from_discard(cardLoc):
	DISCARD.remove_at(cardLoc)
	DISCARD_COUNT.text = str(DISCARD.size())
	check_discard_has_cards()

func check_discard_has_cards():
	if DISCARD.size() <= 0:
		self.get_node("DiscardButton").disabled = true
		print("No Cards in the Discard")
		return false
	else:
		self.get_node("DiscardButton").disabled = false
		return true

func clear_discard_pile():
	DISCARD.clear()
	check_discard_has_cards()
	DISCARD_COUNT.text = str(DISCARD.size())

# Called when the node enters the scene tree for the first time.
func _ready():
	CARD_LIST = FILE_HELPER.list_files_in_directory("res://Data/Cards/")
