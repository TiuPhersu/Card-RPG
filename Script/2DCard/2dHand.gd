extends Node2D

@export var FLOPPY_DISK_ENUM: card_enum.FLOPPY_DISK_ENUM
@export var BATTERY_ENUM: card_enum.BATTERY_ENUM

@export var CARD: PackedScene

func create_card():
	var card = CARD.instantiate()
	card.get_child(0,false).BATTERY_ENUM = str(BATTERY_ENUM)
	card.get_child(0,false).FLOPPY_DISK_ENUM = str(FLOPPY_DISK_ENUM)
	card.set_position(get_global_mouse_position())
	add_child(card)

func _input(event):
	if Input.is_action_just_released("leftclick"):
		create_card()
