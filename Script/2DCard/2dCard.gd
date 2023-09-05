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
@export var CARD_IMAGE: Sprite2D
@export var FLOPPY_DISK_ICON: Sprite2D
@export var BATTERY_ICON: Sprite2D


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
	set_image_card()
