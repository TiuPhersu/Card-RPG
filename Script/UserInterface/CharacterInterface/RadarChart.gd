extends Control

@export var DATA: Array[float] = []
@export var LIMITS: Array[float] = []
@export var LINE_WIDTH: float
@export var LINE_COLOR: Color
@export var POLYGON_COLOR: Color
@export var POLYGON_BACKGROUND_COLOR: Color
@export var TEXT_COLOR: Color

var STATS: Array[String] = ["Constitution", "Strength", "Dexterity", "Intelligence", "Willpower", "Luck"]

var PERIOD
var SIZE = Vector2.ZERO
var RADIUS_OFFSET: float = 200

func set_data(test1, test2, test3, test4, test5, test6):
	DATA.clear()
	DATA.append(test1)
	DATA.append(test2)
	DATA.append(test3)
	DATA.append(test4)
	DATA.append(test5)
	DATA.append(test6)

func _ready():
	PERIOD = 2 * PI / DATA.size()

func _draw():
	create_polygon_background()
	create_polygon()
	create_radar()
	create_radar_axis()

func create_radar():
	var points = []
	var radius = min(SIZE.x, SIZE.y)/2 - RADIUS_OFFSET
	for i in DATA.size():
		var temp = PERIOD * i;
		var way = Vector2(cos(temp), sin(temp))
		points.append(way * radius + SIZE / 2)
	
	points.append(points[0])
	draw_polyline(points, LINE_COLOR, LINE_WIDTH, true)
	for i in points.size():
		draw_line(SIZE, points[i], LINE_COLOR, LINE_WIDTH/2, true)

func create_radar_axis():
	var points = []
	for x in range(1, 6):
		var radius = min(SIZE.x, SIZE.y)/2 - (RADIUS_OFFSET * x/6)
		for i in DATA.size():
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
	for i in DATA.size():
		var temp = PERIOD * i;
		var way = Vector2(cos(temp), sin(temp))
		points.append(way * radius + SIZE / 2)
		pointsColor.append(POLYGON_BACKGROUND_COLOR)
	
	draw_polygon(points, pointsColor)

func create_polygon():
	var points = []
	var pointsColor = []
	var radius = min(SIZE.x, SIZE.y)/2 - RADIUS_OFFSET
	for i in DATA.size():
		var valueRatio = DATA[i] / LIMITS[i]
		var temp = PERIOD * i;
		var way = Vector2(cos(temp), sin(temp))
		points.append(way * radius * valueRatio + SIZE / 2)
		pointsColor.append(POLYGON_COLOR)
	draw_polygon(points,pointsColor)
