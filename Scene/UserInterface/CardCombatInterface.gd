extends Node2D

@export var UNIT_INFO_INTERFACE : Node2D
@export var CARD_INTERFACE : Node2D

var SELECTED_CARD

func show_unit_info(set_unit):
	UNIT_INFO_INTERFACE.show_unit_data(set_unit)

func close_unit_info():
	UNIT_INFO_INTERFACE.close_unit_data()
