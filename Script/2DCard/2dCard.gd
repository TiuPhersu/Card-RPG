extends Node2D

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

@onready var CARD_IMAGE = self.get_node("CardImage")

func set_image_card():
	if IMAGE_PATH == "":
		return
	var image = load(IMAGE_PATH)
	
	
	
	var test = $CardBase.get_rect()
	
	CARD_IMAGE.texture = image

# Called when the node enters the scene tree for the first time.
func _ready():
	#self.get_node("Floppy-Disk-Icon").Floppy_Disk_Enum = 1
	self.get_node("Battery-Icon").select_battery(BATTERY_ENUM)
	self.get_node("Floppy-Disk-Icon").select_battery(FLOPPY_DISK_ENUM)
	self.get_node("Title").set_text(TITLE)
	self.get_node("Description").set_text(DESCRIPTION)
	set_image_card()
