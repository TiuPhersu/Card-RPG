extends Node2D

@export var UNIT_DATA: Resource
@export var LIMIT: float = 100
@export var LINE_WIDTH: float
@export var LINE_COLOR: Color
@export var POLYLINE_COLOR: Color
@export var POLYGON_COLOR: Color
@export var POLYGON_BACKGROUND_COLOR: Color

var ACTUAL_STAT_DATA: Dictionary = {
	"CONSTITUTION": 0, "STRENGTH": 0, "DEXTERITY": 0,
	"INTELLIGENCE": 0, "WILLPOWER": 0, "LUCK": 0}
var BASE_STAT_PERCENTAGE: Dictionary = {
	"CONSTITUTION": 0, "STRENGTH": 0, "DEXTERITY": 0,
	"INTELLIGENCE": 0, "WILLPOWER": 0, "LUCK": 0}
var TOTAL_STAT_PERCENTAGE: Dictionary = {
	"CONSTITUTION": 0, "STRENGTH": 0, "DEXTERITY": 0,
	"INTELLIGENCE": 0, "WILLPOWER": 0, "LUCK": 0}
var PERIOD
var SIZE = Vector2.ZERO
var RADIUS_OFFSET: float = 200
var MAX_STAT:float = 100

@onready var CON_LBL = self.get_node("Constitution/ConstitutionLabel")
@onready var STR_LBL = self.get_node("Strength/StrengthLabel")
@onready var DEX_LBL = self.get_node("Dexterity/DexterityLabel")
@onready var INT_LBL = self.get_node("Intelligence/IntelligenceLabel")
@onready var WIL_LBL = self.get_node("Willpower/WillpowerLabel")
@onready var LUK_LBL = self.get_node("Luck/LuckLabel")

func set_unit_data(set_unit):
	UNIT_DATA = set_unit
	setup()

func set_actual_data():
	ACTUAL_STAT_DATA["CONSTITUTION"] = UNIT_DATA.BASE_CONSTITUTION + UNIT_DATA.ADDITIONAL_CONSTITUTION
	ACTUAL_STAT_DATA["STRENGTH"] = UNIT_DATA.BASE_STRENGTH + UNIT_DATA.ADDITIONAL_STRENGTH
	ACTUAL_STAT_DATA["DEXTERITY"] = UNIT_DATA.BASE_DEXTERITY + UNIT_DATA.ADDITIONAL_DEXTERITY
	ACTUAL_STAT_DATA["INTELLIGENCE"] = UNIT_DATA.BASE_INTELLIGENCE + UNIT_DATA.ADDITIONAL_INTELLIGENCE
	ACTUAL_STAT_DATA["WILLPOWER"] = UNIT_DATA.BASE_WILLPOWER + UNIT_DATA.ADDITIONAL_WILLPOWER
	ACTUAL_STAT_DATA["LUCK"] = UNIT_DATA.BASE_LUCK + UNIT_DATA.ADDITIONAL_LUCK

func set_percentage_data():	
	BASE_STAT_PERCENTAGE["CONSTITUTION"] = (UNIT_DATA.BASE_CONSTITUTION / MAX_STAT) * 100
	BASE_STAT_PERCENTAGE["STRENGTH"] = (UNIT_DATA.BASE_STRENGTH / MAX_STAT) * 100
	BASE_STAT_PERCENTAGE["DEXTERITY"] = (UNIT_DATA.BASE_DEXTERITY / MAX_STAT) * 100
	BASE_STAT_PERCENTAGE["INTELLIGENCE"] = (UNIT_DATA.BASE_INTELLIGENCE / MAX_STAT) * 100
	BASE_STAT_PERCENTAGE["WILLPOWER"] = (UNIT_DATA.BASE_WILLPOWER / MAX_STAT) * 100
	BASE_STAT_PERCENTAGE["LUCK"] = (UNIT_DATA.BASE_LUCK / MAX_STAT) * 100
	
	TOTAL_STAT_PERCENTAGE["CONSTITUTION"] = ((UNIT_DATA.BASE_CONSTITUTION + UNIT_DATA.ADDITIONAL_CONSTITUTION) / MAX_STAT) * 100
	TOTAL_STAT_PERCENTAGE["STRENGTH"] = ((UNIT_DATA.BASE_STRENGTH + UNIT_DATA.ADDITIONAL_STRENGTH) / MAX_STAT) * 100
	TOTAL_STAT_PERCENTAGE["DEXTERITY"] = ((UNIT_DATA.BASE_DEXTERITY + UNIT_DATA.ADDITIONAL_DEXTERITY) / MAX_STAT) * 100
	TOTAL_STAT_PERCENTAGE["INTELLIGENCE"] = ((UNIT_DATA.BASE_INTELLIGENCE + UNIT_DATA.ADDITIONAL_INTELLIGENCE) / MAX_STAT) * 100
	TOTAL_STAT_PERCENTAGE["WILLPOWER"] = ((UNIT_DATA.BASE_WILLPOWER + UNIT_DATA.ADDITIONAL_WILLPOWER) / MAX_STAT) * 100
	TOTAL_STAT_PERCENTAGE["LUCK"] = ((UNIT_DATA.BASE_LUCK + UNIT_DATA.ADDITIONAL_LUCK) / MAX_STAT) * 100

func set_ranking():
	CON_LBL.text = determine_rank(TOTAL_STAT_PERCENTAGE["CONSTITUTION"])
	STR_LBL.text = determine_rank(TOTAL_STAT_PERCENTAGE["STRENGTH"])
	DEX_LBL.text = determine_rank(TOTAL_STAT_PERCENTAGE["DEXTERITY"])
	INT_LBL.text = determine_rank(TOTAL_STAT_PERCENTAGE["INTELLIGENCE"])
	WIL_LBL.text = determine_rank(TOTAL_STAT_PERCENTAGE["WILLPOWER"])
	LUK_LBL.text = determine_rank(TOTAL_STAT_PERCENTAGE["LUCK"])

func determine_max_stat():
	var cur_max : float = ACTUAL_STAT_DATA.values()[0]
	for stat in ACTUAL_STAT_DATA:  
		if ACTUAL_STAT_DATA[stat] > cur_max:  
			cur_max = ACTUAL_STAT_DATA[stat]
	MAX_STAT = cur_max

func determine_rank(value):
	var rank
	if value >= 80:
		rank = "A"
	elif value >= 60 and value < 80:
		rank = "B"
	elif value >= 40 and value < 60:
		rank = "C"
	elif value >= 20 and value < 40:
		rank = "D"
	elif value >= 0 and value < 20:
		rank = "F"
	else:
		rank = "?"
	return rank

func setup():
	set_actual_data()
	determine_max_stat()
	set_percentage_data()
	set_ranking()
	PERIOD = 2 * PI / BASE_STAT_PERCENTAGE.size()

func _draw():
	create_polygon_background()
	create_radar_axis()
	create_radar()
	create_polygon()
	create_polyline()

func create_radar():
	var points = []
	var radius = min(SIZE.x, SIZE.y)/2 - RADIUS_OFFSET
	for i in BASE_STAT_PERCENTAGE.size():
		var temp = PERIOD * i;
		var way = Vector2(cos(temp), sin(temp))
		points.append(way * radius + SIZE / 2)
	
	points.append(points[0])
	draw_polyline(points, LINE_COLOR, LINE_WIDTH, true)
	for i in points.size():
		draw_line(SIZE, points[i], LINE_COLOR, LINE_WIDTH/2, true)

func create_radar_axis():
	var points = []
	for x in range(1, 5):
		var radius = min(SIZE.x, SIZE.y)/2 - (RADIUS_OFFSET * x/5)
		for i in BASE_STAT_PERCENTAGE.size():
			var temp = PERIOD * i;
			var way = Vector2(cos(temp), sin(temp))
			points.append(way * radius + SIZE / 2)
		points.append(points[0])
		draw_polyline(points, LINE_COLOR, LINE_WIDTH/2,true)
		points.clear()

func create_polygon_background():
	var points = []
	var pointsColor = []
	var radius = min(SIZE.x, SIZE.y)/2 - RADIUS_OFFSET
	for i in BASE_STAT_PERCENTAGE.size():
		var temp = PERIOD * i;
		var way = Vector2(cos(temp), sin(temp))
		points.append(way * radius + SIZE / 2)
		pointsColor.append(POLYGON_BACKGROUND_COLOR)
	
	draw_polygon(points, pointsColor)

func create_polyline():
	var points = []
	var radius = min(SIZE.x, SIZE.y)/2 - RADIUS_OFFSET
	var i = 0
	for key in BASE_STAT_PERCENTAGE:
		var valueRatio = BASE_STAT_PERCENTAGE[key] / LIMIT
		var temp = PERIOD * i;
		var way = Vector2(cos(temp), sin(temp))
		points.append(way * radius * valueRatio + SIZE / 2)
		i = i + 1
	points.append(points[0])
	draw_polyline(points, POLYLINE_COLOR, LINE_WIDTH, true)

func create_polygon():
	var points = []
	var pointsColor = []
	var radius = min(SIZE.x, SIZE.y)/2 - RADIUS_OFFSET
	var i = 0
	for key in TOTAL_STAT_PERCENTAGE:
		var valueRatio = TOTAL_STAT_PERCENTAGE[key] / LIMIT
		var temp = PERIOD * i;
		var way = Vector2(cos(temp), sin(temp))
		points.append(way * radius * valueRatio + SIZE / 2)
		pointsColor.append(POLYGON_COLOR)
		i = i + 1
	draw_polygon(points,pointsColor)
