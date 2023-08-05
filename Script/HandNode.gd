extends Node3D

@onready var Draw_Button = get_node("DrawButton");
@onready var Play_Button = get_node("PlayButton");
@onready var Hand = get_node("Hand");

@export var Card_Count: int

# Called when the node enters the scene tree for the first time.
func _ready():
	Hand.draw_hand(Card_Count)
	Draw_Button.connect("pressed", self.drawCard)
	Play_Button.connect("pressed", self.playCard)

func drawCard():
	Hand.draw_card(1)
	Hand.spread_cards()

func playCard():
	Hand.play_card(1)
	Hand.spread_cards()
