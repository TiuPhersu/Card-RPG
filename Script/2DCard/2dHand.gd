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
@onready var CHECK_STATE_ALL = false

var SELECTED_CARD
var START_POS

func focus_card_in_hand(pressed, released):
	var hand = self
	for card in hand.get_children(false):
		if card.STATE == card_enum.CARD_STATE_ENUM.FocusInHand || card.STATE == card_enum.CARD_STATE_ENUM.InMouse:
			SELECTED_CARD = card
#			print(card)
	
	if SELECTED_CARD == null:
		return null

	match SELECTED_CARD.STATE:
		card_enum.CARD_STATE_ENUM.FocusInHand, card_enum.CARD_STATE_ENUM.InMouse, card_enum.CARD_STATE_ENUM.InPlay:
			if pressed:
				if !SELECTED_CARD.CARD_SELECTED:
					SELECTED_CARD.STATE = card_enum.CARD_STATE_ENUM.InMouse
					SELECTED_CARD.CARD_SELECTED = true
					disable_cards()
					print(SELECTED_CARD)
					return(SELECTED_CARD)
					
				else:
					enable_cards()
					return null
			elif released:
				enable_cards()
				return null

func disable_cards():
	var zCounter = 0
	var hand = self
	for card in hand.get_children(false):
		if card.STATE != card_enum.CARD_STATE_ENUM.InMouse:
			card.STATE = card_enum.CARD_STATE_ENUM.ReorganizeHand
			card.scale = Vector2(1,1)
			card.SETUP = false
			card.z_index = zCounter
			zCounter += 1

func enable_cards():
	if SELECTED_CARD != null:
		SELECTED_CARD.STATE = card_enum.CARD_STATE_ENUM.ReorganizeHand
		SELECTED_CARD.CARD_SELECTED = false
		SELECTED_CARD.SETUP = true
		SELECTED_CARD.position = SELECTED_CARD.TARGET_POS
#	print(SELECTED_CARD)
	var hand = self
	for card in hand.get_children(false):
		card.STATE = card_enum.CARD_STATE_ENUM.ReorganizeHand
		card.CARD_SELECTED = false
		card.SETUP = true

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

func create_card_from_database(selectedCard, startPos) -> bool:
	if selectedCard == null:
		print("No Cards. Create Card From Database.")
		return false
	
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
	spread_hand(startPos)
	return true

func remove_card_from_hand(selectedCard: Node2D) -> bool:
	if selectedCard == null:
		print("No Cards. Remove Card From Hand.")
		return false
		
	selectedCard.queue_free()
	
	await get_tree().create_timer(0.01).timeout
	spread_hand(null)
	return true

func spread_hand(startPos):
	var hand = self
	
	var zCounter = 0
	for card in hand.get_children(false):
		var handRatio = 0
		var destination = hand.global_transform
#		var view = VIEWPORT_SIZE / Vector2(4.5,1.258)
		var view = Vector2(340, 687)
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
		
		if  card.get_index() == (hand.get_child_count(false) - 1) && startPos != null:
			card.START_POS = startPos
			card.STATE = card_enum.CARD_STATE_ENUM.MoveDrawnCardToHand
		else:
			card.START_POS = destination
			card.STATE = card_enum.CARD_STATE_ENUM.ReorganizeHand
		
		card.TARGET_POS = destination
		card.OLD_POS = destination
		
		card.z_index = zCounter
		zCounter += 1

# BUGGED: Anytime a card is selected it will enter or exit the Area2d 
# (will probably need to find an alternative method instead of using signals)
func _on_hand_area_mouse_entered():
	if SELECTED_CARD != null:
		SELECTED_CARD.IN_HAND_AREA = true

func _on_hand_area_mouse_exited():
	if SELECTED_CARD != null:
		SELECTED_CARD.IN_HAND_AREA = false

func _on_play_area_mouse_entered():
	if SELECTED_CARD != null:
		SELECTED_CARD.IN_PLAY_AREA = true

func _on_play_area_mouse_exited():
	if SELECTED_CARD != null:
		SELECTED_CARD.IN_PLAY_AREA = false
