extends Node2D

@export_category("Card Data")
@export var FLOPPY_DISK_ENUM: card_enum.FLOPPY_DISK_ENUM:
	get: return FLOPPY_DISK_ENUM
	set(value): FLOPPY_DISK_ENUM = value
	
@export var BATTERY_ENUM: card_enum.BATTERY_ENUM:
	get: return BATTERY_ENUM
	set(value): BATTERY_ENUM = value

@export var TITLE: String:
	get: return TITLE
	set(value): TITLE = value

@export var DESCRIPTION: String:
	get: return DESCRIPTION
	set(value): DESCRIPTION = value

@export var IMAGE_PATH: String:
	get: return IMAGE_PATH
	set(value): IMAGE_PATH = value
	
@export_category("Card Component")
@export var TITLE_LABEL: Label
@export var DESCRIPTION_LABEL: Label
@export var CARD_IMAGE: TextureRect
@export var FLOPPY_DISK_ICON: Sprite2D
@export var BATTERY_ICON: Sprite2D

@onready var STATE: card_enum.CARD_STATE_ENUM
@onready var START_POS
@onready var TARGET_POS

var T = 0
var DRAW_TIME = .15

func set_image_card():
	if IMAGE_PATH == "":
		return
	var image = load(IMAGE_PATH)
	
	CARD_IMAGE.texture = image

# Called when the node enters the scene tree for the first time.
func _ready():
	#self.get_node("Floppy-Disk-Icon").Floppy_Disk_Enum = 1
	BATTERY_ICON.select_battery(BATTERY_ENUM)
	FLOPPY_DISK_ICON.select_battery(FLOPPY_DISK_ENUM)
	TITLE_LABEL.set_text(TITLE)
	DESCRIPTION_LABEL.set_text(DESCRIPTION)
	STATE = card_enum.CARD_STATE_ENUM.InHand
	set_image_card()

func _physics_process(delta):
	match STATE:
		card_enum.CARD_STATE_ENUM.InHand:
			pass
		card_enum.CARD_STATE_ENUM.InPlay:
			pass
		card_enum.CARD_STATE_ENUM.InMouse:
			pass
		card_enum.CARD_STATE_ENUM.FocusInHand:
			scale = Vector2(1.2,1.2)
			z_index = 100
		card_enum.CARD_STATE_ENUM.MoveDrawnCardToHand:
			move_to_destination(delta, true)
		card_enum.CARD_STATE_ENUM.ReorganizeHand:
			move_to_destination(delta, false)

func move_to_destination(delta, decktoHand):
	if T <= 1:
		position = START_POS.lerp(TARGET_POS, T)
		if decktoHand:
			scale = Vector2(T,T)
		T += delta/float(DRAW_TIME)
	else:
		position = TARGET_POS
		START_POS = TARGET_POS
		scale = Vector2(1,1)
		STATE = card_enum.CARD_STATE_ENUM.InHand
		z_index = 0
		T = 0
	
func _on_selection_mouse_entered():
	match STATE:
		card_enum.CARD_STATE_ENUM.InHand, card_enum.CARD_STATE_ENUM.ReorganizeHand:
			STATE = card_enum.CARD_STATE_ENUM.FocusInHand


func _on_selection_mouse_exited():
	match STATE:
		card_enum.CARD_STATE_ENUM.FocusInHand:
			STATE = card_enum.CARD_STATE_ENUM.ReorganizeHand
