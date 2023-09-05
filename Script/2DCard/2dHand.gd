extends Node2D

@export var CARD_SIZE: float = 0

@export var TITLE: String
@export var DESCRIPTION: String
@export var FLOPPY_DISK_ENUM: card_enum.FLOPPY_DISK_ENUM
@export var BATTERY_ENUM: card_enum.BATTERY_ENUM
@export var IMAGE: String

@export var CARD: PackedScene

@onready var FILE_HELPER = file_helper.new()

var CardOffset = Vector2()
@onready var ViewportSize = Vector2(get_viewport().size)
@onready var CenterCard = ViewportSize * Vector2(0.5, 1.25)
@onready var Hor_rad = ViewportSize.x * 0.45
@onready var Ver_rad = ViewportSize.y * 0.4

var angle = 0
var OvalAngleVector = Vector2()

func create_card():
	var card = CARD.instantiate()
	card.TITLE = TITLE
	card.DESCRIPTION = DESCRIPTION
	card.BATTERY_ENUM = str(BATTERY_ENUM)
	card.FLOPPY_DISK_ENUM = str(FLOPPY_DISK_ENUM)
	card.IMAGE_PATH = IMAGE
	card.set_position(get_global_mouse_position())
	card.scale.x *= CARD_SIZE / card.scale.x
	card.scale.y *= CARD_SIZE / card.scale.y
	add_child(card)

func create_card_from_database(selectedCard):
	if selectedCard == null:
		print("NULL")
		return
	var card = CARD.instantiate()
	var cardData = FILE_HELPER.load_single_card_resource("res://Data/Cards/" + selectedCard)
	card.TITLE = cardData.TITLE
	card.DESCRIPTION = cardData.DESCRIPTION
	card.BATTERY_ENUM = cardData.COST
	card.FLOPPY_DISK_ENUM = cardData.TYPE
	card.IMAGE_PATH = cardData.IMAGE_PATH
	
	#card.set_position(get_global_mouse_position())
	OvalAngleVector = Vector2(Hor_rad * cos(angle), - Ver_rad * sin(angle))
	var test = (card.get_node("CardBase").texture.get_size() * 3)
	print(test)
	card.set_position(CenterCard - test)
	card.scale.x *= CARD_SIZE / card.scale.x
	card.scale.y *= CARD_SIZE / card.scale.y
	add_child(card)
