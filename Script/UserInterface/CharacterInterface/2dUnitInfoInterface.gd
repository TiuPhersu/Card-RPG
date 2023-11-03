extends Control

@onready var RADAR_CHART = self.get_node("RadarChart")

func _ready():
	RADAR_CHART.set_data(10,20,30,40,50,60)
