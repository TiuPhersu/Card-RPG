extends Node3D

const CARD = preload("res://Scene/3d/Card.tscn")

@export_category("Hand Setting")
@export var Max_Hand: int
@export var Hand_Width: int
@export var Spread_Curve: Curve
@export var Height_Curve: Curve
@export var Rotation_Curve: Curve

var Selected_Card
var card_counter_fun: int = 0
var Deck

func draw_hand(cardCount) -> void:
	for _x in cardCount:
		var drawnCard = Deck.draw_cards()
		if drawnCard != null:
			add_child(drawnCard)
			init_select_card()
			spread_cards()

func draw_card() -> int:
	if self.get_child_count(false) + 1 > Max_Hand:
		return -1

	var drawnCard = Deck.draw_cards()
	if drawnCard != null:
		add_child(drawnCard)
		init_select_card()
		spread_cards()
		return 0
	else:
		return -1

func play_card(cardLoc) -> int:
	# TODO: Work on actually playing cards or sending cards to discard pile
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
	var spread
	var z_overlap
	var height
	var card_position
	var card_rotation
	
	
	for card in hand.get_children():
		var hand_ratio = 0.5
		var destination = $".".global_transform
		var camera = get_viewport().get_camera_3d()
		destination.basis =  camera.global_transform.basis
		if hand.get_child_count(false) > 1:
			hand_ratio = float(card.get_index()) / float(hand.get_child_count(false) - 1)
		
		destination.origin.x += Spread_Curve.sample(hand_ratio) * Hand_Width
		destination.origin += camera.basis * Vector3.BACK * hand_ratio * .2
#		card.global_rotation_degrees += Rotation_Curve.sample(hand_ratio)* .2
		
		if hand.get_child_count(false) > 3:
			destination.origin += camera.basis * Vector3.DOWN * Height_Curve.sample(hand_ratio)
			card_rotation = Rotation_Curve.sample(hand_ratio) * 0.2
			card.set_rotation(Vector3(0, card_rotation, 0))
		else:
			card.set_rotation(Vector3(0, 0, 0))
		
		card.set_global_position(destination.origin)

#func spread_cards() -> void:
#	var hand = self
#	var spread
#	var z_overlap
#	var height
#	var card_position
#	var card_rotation
#
#	for card in hand.get_children():
#		var hand_ratio = 0.5
#
#		if hand.get_child_count(false) > 3:
#			hand_ratio = float(card.get_index()) / float(hand.get_child_count(false) - 1)
#			spread = Spread_Curve.sample(hand_ratio) * Hand_Width
#			z_overlap = card.get_index() * .1
#			height = Height_Curve.sample(hand_ratio)
#			card_position = Vector3(spread, z_overlap,height)
#			card_rotation = Rotation_Curve.sample(hand_ratio) * 0.2
#
#			card.set_position(card_position)
#			card.set_rotation(Vector3(0, card_rotation, 0))
#
#		elif hand.get_child_count(false) == 3:
#			hand_ratio = .35 * (card.get_index() + .45)
#			spread = Spread_Curve.sample(hand_ratio) * Hand_Width
#			z_overlap = card.get_index() * .1
#			card_position = Vector3(spread, z_overlap,0)
#			card.set_position(card_position)
#			card.set_rotation(Vector3(0, 0, 0))
#
#		elif hand.get_child_count(false) == 2:
#			hand_ratio = .35 * (card.get_index() + .95)
#			spread = Spread_Curve.sample(hand_ratio) * Hand_Width
#			z_overlap = card.get_index() * .1
#			card_position = Vector3(spread, z_overlap,0)
#			card.set_position(card_position)
#			card.set_rotation(Vector3(0, 0, 0))
#
#		else:
#			hand_ratio = .5
#			spread = Spread_Curve.sample(hand_ratio) * Hand_Width
#			card_position = Vector3(spread, 0,0)
#			card.set_position(card_position)

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
	
func _ready():
	Deck = self.get_parent().get_parent().get_node("Deck")
	
#func _process(delta):
#	var card = self.get_child(0)
#	##card.position = card.position.move_toward(Vector3(0,0,0), delta * 10)
#
#	card.rotation.z = lerp(card.rotation.z, atan(1), delta)
