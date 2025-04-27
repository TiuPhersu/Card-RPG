extends Node2D

@export var UNIT_DATA: Resource
@onready var RADAR_CHART = self.get_node("PotentialWindow/RadarChart")
@onready var CHARACTER_WINDOW = self.get_node("CharacterWindow")
@onready var PARAMETER_WINDOW = self.get_node("ParameterWindow")
@onready var PORTRAIT = self.get_node("PortraitWindow/TextureRect")

func show_unit_data(set_unit):
	if set_unit == null:
		print("There is no unit data. Please create data for the unit.")
		return
	UNIT_DATA = set_unit
	RADAR_CHART.set_unit_data(UNIT_DATA)
	CHARACTER_WINDOW.set_unit_data(UNIT_DATA)
	PARAMETER_WINDOW.set_unit_data(UNIT_DATA)
	var image = load(UNIT_DATA.CHARACTER_ICON)
	PORTRAIT.texture = image
	self.visible = true
	
func close_unit_data():
	self.visible = false
