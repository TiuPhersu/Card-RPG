extends Control

@onready var COST_DROPDOWN = $CostOptionButton
@onready var TYPE_DROPDOWN = $TypeOptionButton
@onready var BLOCK_DROPDOWN = $BlockOptionButton
@onready var ATTACK_DROPDOWN = $AttackOptionButton
@onready var CARD_DROPDOWN = $LoadOptionButton
@onready var TITLE_TEXT = $TitleTextEdit
@onready var DESCRIPTION_TEXT = $DescriptionTextEdit

@onready var Save_Button = get_node("SaveButton")
@onready var Load_Button = get_node("LoadButton")
@onready var Reset_Button = get_node("ResetButton")
@onready var Delete_Button = get_node("DeleteButton")

@onready var DISPLAY = $DisplayCardNode
@onready var FILE_HELPER = file_helper.new()

@export var CARD: PackedScene
@export var CARD_DATA: card_data

var OLD_FILE_LOCATION = null

func add_items_block():
	BLOCK_DROPDOWN.clear()
	
	for i in 100:
		BLOCK_DROPDOWN.add_item(str(i))

func add_items_attack():
	ATTACK_DROPDOWN.clear()
	
	for i in 100:
		ATTACK_DROPDOWN.add_item(str(i))

func add_items_cost():
	COST_DROPDOWN.clear()
	
	for i in card_enum.BATTERY_ENUM.keys():
		COST_DROPDOWN.add_item(str(i))

func add_items_type():
	TYPE_DROPDOWN.clear()
	
	for i in card_enum.FLOPPY_DISK_ENUM.keys():
		TYPE_DROPDOWN.add_item(str(i))

func add_items_card():
	CARD_DROPDOWN.clear()
	
	var cardList = FILE_HELPER.list_files_in_directory("res://Data/Cards/")
	
	for card in cardList:
		CARD_DROPDOWN.add_item(str(card))

func create_card():
	if self.get_node("DisplayCardNode").get_child_count() > 0 :
		DISPLAY.remove_child(self.get_node("DisplayCardNode").get_child(0))
	
	var card = CARD.instantiate()
	
	card.get_child(0, false).TITLE = TITLE_TEXT.text

	card.get_child(0, false).DESCRIPTION = DESCRIPTION_TEXT.text
	
	card.get_child(0, false).BATTERY_ENUM = COST_DROPDOWN.get_selected_id()

	card.get_child(0, false).FLOPPY_DISK_ENUM = TYPE_DROPDOWN.get_selected_id()

	DISPLAY.add_child(card)

func save_card():
	print("Saving Card")
	CARD_DATA = card_data.new()
	CARD_DATA.COST = COST_DROPDOWN.selected
	CARD_DATA.TYPE = TYPE_DROPDOWN.selected
	CARD_DATA.ATTACK = ATTACK_DROPDOWN.selected
	CARD_DATA.BLOCK = BLOCK_DROPDOWN.selected
	CARD_DATA.TITLE = TITLE_TEXT.text
	CARD_DATA.DESCRIPTION = DESCRIPTION_TEXT.text
	
	var newCardLocation = "res://Data/Cards/" + CARD_DATA.TITLE + ".tres"
	
	FILE_HELPER.save_single_card_resource(CARD_DATA, newCardLocation, OLD_FILE_LOCATION)
	
	OLD_FILE_LOCATION = newCardLocation
	
	add_items_card()

func load_card():
	print("Loading Card")
	var cardFileName = str(CARD_DROPDOWN.get_item_text(CARD_DROPDOWN.get_selected_id()))
	OLD_FILE_LOCATION = "res://Data/Cards/" + cardFileName
	
	var card = FILE_HELPER.load_single_card_resource(OLD_FILE_LOCATION)
	COST_DROPDOWN.select(card.COST)
	TYPE_DROPDOWN.select(card.TYPE)
	ATTACK_DROPDOWN.select(card.ATTACK)
	BLOCK_DROPDOWN.select(card.BLOCK)
	TITLE_TEXT.text = card.TITLE
	DESCRIPTION_TEXT.text = card.DESCRIPTION
	create_card()

func reset_card():
	COST_DROPDOWN.select(0)
	TYPE_DROPDOWN.select(0)
	ATTACK_DROPDOWN.select(0)
	BLOCK_DROPDOWN.select(0)
	TITLE_TEXT.text = ""
	DESCRIPTION_TEXT.text = ""
	OLD_FILE_LOCATION = null

func delete_card():
	if OLD_FILE_LOCATION != null:
		FILE_HELPER.delete_single_card_resource(OLD_FILE_LOCATION)
		reset_card()
		load_dropdown()
		print("Card Deleted")
		

func load_dropdown():
	add_items_attack()
	add_items_block()
	add_items_cost()
	add_items_type()
	add_items_card()

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dropdown()
	Save_Button.connect("pressed", self.save_card)
	Load_Button.connect("pressed", self.load_card)
	Reset_Button.connect("pressed", self.reset_card)
	Delete_Button.connect("pressed", self.delete_card)
	create_card()

func _input(event):
	create_card()
