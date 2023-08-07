extends Node3D

const CARD = preload("res://Scene/Card.tscn")

@export_category("Hand Setting")
@export var Max_Hand: int
@export var Hand_Width: int
@export var Spread_Curve: Curve
@export var Height_Curve: Curve
@export var Rotation_Curve: Curve

var Selected_Card

func draw_hand(cardCount) -> void:
	for _x in cardCount:
		var card = CARD.instantiate()
		add_child(card)
	spread_cards()
	init_select_card()

func draw_card(cardCount) -> int:
	if self.get_child_count(false) + 1 > Max_Hand:
		return -1
		
	for _x in cardCount:
		var card = CARD.instantiate()
		add_child(card)
		
	Selected_Card.hide_animation()
	init_select_card()
	return 0

func play_card(cardLoc) -> int:
	if self.get_child_count(false) <= 0:
		return -1
		
	self.remove_child((self.get_child(cardLoc)))
	
	if self.get_child_count(false) > 0:
		init_select_card()
		return 0
	else:
		return cardLoc;

func spread_cards() -> void:
	var hand = self
	
	for card in hand.get_children():
		var hand_ratio = 0.5
		
		if hand.get_child_count(false) > 1:
			hand_ratio = float(card.get_index()) / float(hand.get_child_count(false) - 1)
		
		var spread = Spread_Curve.sample(hand_ratio) * Hand_Width
		var z_overlap = card.get_index() * .1
		var height = Height_Curve.sample(hand_ratio)
		var card_position = Vector3(spread, z_overlap,height)
		var card_rotation = Rotation_Curve.sample(hand_ratio) * 0.2
		card.set_position(card_position)
		card.set_rotation(Vector3(0, card_rotation, 0))

func init_select_card() -> void:
	Selected_Card = self.get_child(0)
	Selected_Card.show_animation()

func select_card_right() -> int:
	var next_card_index
	if Selected_Card.get_index() < self.get_child_count(false) - 1 :
		next_card_index = Selected_Card.get_index() + 1
	else:
		return -1
	
	Selected_Card.hide_animation()
	Selected_Card = self.get_child(next_card_index)
	Selected_Card.show_animation()
	
	return next_card_index;
	
func select_card_left() -> int:
	var next_card_index
	if Selected_Card.get_index() > 0 :
		next_card_index = Selected_Card.get_index() - 1
	else:
		return -1
	
	Selected_Card.hide_animation()
	Selected_Card = self.get_child(next_card_index)
	Selected_Card.show_animation()
	
	return next_card_index;
	
