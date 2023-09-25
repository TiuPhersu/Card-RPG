extends Node2D

@export_category("Character Data")
@export var CHARACTER_ICON_ENUM: character_enum.CHARACTER_ICON_ENUM:
	get: return CHARACTER_ICON_ENUM
	set(value): CHARACTER_ICON_ENUM = value
	
@export var HEART_ICON_ENUM: character_enum.HEART_ICON_ENUM:
	get: return HEART_ICON_ENUM
	set(value): HEART_ICON_ENUM = value

@export var HEALTH: int:
	get: return HEALTH
	set(value): HEALTH = value
	
@export_category("Card Component")
@export var HEALTH_LABEL: Label
@export var HEALTH_BAR: TextureProgressBar
@export var CHARACTER_ICON: Sprite2D
@export var HEART_ICON: Sprite2D

func _ready():
	CHARACTER_ICON.select_character(CHARACTER_ICON_ENUM)
	HEART_ICON.select_heart(HEART_ICON_ENUM)
	HEALTH_LABEL.set_text(str(HEALTH) + "/100")
	HEALTH_BAR.set_value_no_signal(HEALTH)
