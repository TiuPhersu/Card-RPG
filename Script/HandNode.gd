extends Node3D

@onready var Draw_Button = get_node("DrawButton");
@onready var Play_Button = get_node("PlayButton");
@onready var Right_Button = get_node("RightButton");
@onready var Left_Button = get_node("LeftButton");
@onready var Hand = get_node("Hand");

@export var Card_Count: int
var Selected_Card_Index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	Hand.draw_hand(Card_Count)
	Draw_Button.connect("pressed", self.draw_card)
	Play_Button.connect("pressed", self.play_card)
	Right_Button.connect("pressed", self.move_right)
	Left_Button.connect("pressed", self.move_left)

func draw_card():
	Hand.draw_card(1)
	Hand.spread_cards()

func play_card():
	Selected_Card_Index = Hand.play_card(Selected_Card_Index)
	Hand.spread_cards()

func move_right():
	Selected_Card_Index = Hand.select_card_right()
	#print(Selected_Card_Index)

func move_left():
	Selected_Card_Index = Hand.select_card_left()
	#print(Selected_Card_Index)
