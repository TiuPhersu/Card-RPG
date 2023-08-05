extends Node3D

const CARD = preload("res://Scene/Card.tscn")

@export var Hand_Width: int
@export var Spread_Curve: Curve
@export var Height_Curve: Curve
@export var Rotation_Curve: Curve

func draw_hand(cardCount) -> void:
	for _x in cardCount:
		var card = CARD.instantiate()
		add_child(card)

func draw_card(cardCount) -> void:
	for _x in cardCount:
		var card = CARD.instantiate()
		add_child(card)

func play_card(cardCount) -> void:
	var hand = self
	for _x in cardCount:
		hand.remove_child(hand.get_child(_x))

func spread_cards() -> void:
	var hand = self
	
	for card in hand.get_children():
		var hand_ratio = 0.5
		
		if hand.get_child_count() > 1:
			hand_ratio = float(card.get_index()) / float(hand.get_child_count() - 1)
		
		var spread = Spread_Curve.sample(hand_ratio) * Hand_Width
		var z_overlap = card.get_index() * .2
		var height = Height_Curve.sample(hand_ratio)
		var card_position = Vector3(spread, z_overlap,height)
		var rotation = Rotation_Curve.sample(hand_ratio) * 0.2
		card.set_position(card_position)
		card.set_rotation(Vector3(0, rotation, 0))
