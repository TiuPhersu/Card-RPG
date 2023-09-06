extends Node2D

@export var CARD_SIZE: float = 0

@export var TITLE: String
@export var DESCRIPTION: String
@export var FLOPPY_DISK_ENUM: card_enum.FLOPPY_DISK_ENUM
@export var BATTERY_ENUM: card_enum.BATTERY_ENUM
@export var IMAGE: String

@export var SPREAD_CURVE: Curve
@export var HAND_WIDTH: int

@export var CARD: PackedScene

@onready var FILE_HELPER = file_helper.new()

@onready var VIEWPORT_SIZE = Vector2(get_viewport().size)

var Z_COUNTER = 0

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

func create_card_from_database(selectedCard, startpos):
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

	card.scale.x *= CARD_SIZE / card.scale.x
	card.scale.y *= CARD_SIZE / card.scale.y
	add_child(card)
	spread_hand(startpos)

func spread_hand(startpos):
	var hand = self

	for card in hand.get_children(false):
		var handRatio = 0
		var destination = hand.global_transform
		var view = VIEWPORT_SIZE / Vector2(5,1.45)
		destination = view

		if hand.get_child_count(false) > 1:
			handRatio = float(card.get_index()) / float(hand.get_child_count(false) - 1)
		
		if hand.get_child_count(false) >= 5:
			destination.x += SPREAD_CURVE.sample(handRatio) * HAND_WIDTH
		elif hand.get_child_count(false) >= 4:
			destination.x += SPREAD_CURVE.sample(handRatio) * HAND_WIDTH/1.333
		elif hand.get_child_count(false) >= 3:
			destination.x += SPREAD_CURVE.sample(handRatio) * HAND_WIDTH/2
		elif hand.get_child_count(false) >= 2:
			destination.x += SPREAD_CURVE.sample(handRatio) * HAND_WIDTH/4
		
		# card.set_global_position(destination)
		
		if  card.get_index() == (hand.get_child_count(false) - 1):
			card.START_POS = startpos
		else:
			card.START_POS = destination
		
		card.TARGET_POS = destination
		card.STATE = card_enum.CARD_STATE_ENUM.MoveDrawnCardToHand
			
		card.z_index = Z_COUNTER
		Z_COUNTER += 1
		print(Z_COUNTER)
	Z_COUNTER = 0
