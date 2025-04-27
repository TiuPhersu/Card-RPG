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
@onready var OLD_STATE: card_enum.CARD_STATE_ENUM
@onready var START_POS
@onready var TARGET_POS
@onready var OLD_POS
@onready var TARGET_LINE = self.get_node("SelectTargetLine")
@onready var T = 0
@onready var DRAW_TIME = .15
@onready var SETUP = true
@onready var CARD_SELECTED = false

# TODO Repurpose to target when cards target and drag if not
@onready var IN_HAND_AREA = false # Set true if implementing the drag/targeting (currently turning off and only target)
@onready var IN_PLAY_AREA = false # Set false if implementing the drag/targeting (currently turning off and only target)

@onready var TARGETING = false
@export var COLLISION:Area2D

func _physics_process(delta):
	checkCollision()
	checkHover()
	match STATE:
		card_enum.CARD_STATE_ENUM.InHand:
			pass
		card_enum.CARD_STATE_ENUM.InPlay:
			pass
		card_enum.CARD_STATE_ENUM.InMouse:
			if TARGETING:
				card_targeting()
			else:
				card_dragging()
			#if !IN_PLAY_AREA:
				#card_dragging()
			#elif IN_PLAY_AREA:
				#card_targeting()
			#else:
				#reset_line(TARGET_LINE)
		card_enum.CARD_STATE_ENUM.FocusInHand:
			focus_card()
		card_enum.CARD_STATE_ENUM.MoveDrawnCardToHand:
			move_to_destination(delta, true)
		card_enum.CARD_STATE_ENUM.ReorganizeHand:
			move_to_destination(1, false)

func checkCollision():
	if COLLISION == null:
		return
	var overlapping_areas = COLLISION.get_overlapping_areas()
	if overlapping_areas.size() > 0:
		#print(overlapping_areas[0].name)
		if(overlapping_areas[0].name == "PlayArea2D"):
			TARGETING = true
			#TARGET_LINE.visible = true
			#print("overlapping")
			IN_PLAY_AREA = true
	else:
		#TARGET_LINE.visible = false
		TARGETING = false
		IN_PLAY_AREA = false
		#print("not overlapping")

func checkHover():
	if self.get_node("Selection").is_hovered() :
		focus_in()
	else:
		focus_out()

func _ready():
	BATTERY_ICON.select_battery(BATTERY_ENUM)
	FLOPPY_DISK_ICON.select_battery(FLOPPY_DISK_ENUM)
	TITLE_LABEL.set_text(TITLE)
	DESCRIPTION_LABEL.set_text(DESCRIPTION)
	STATE = card_enum.CARD_STATE_ENUM.InHand
	scale = Vector2.ZERO
	set_image_card()

func set_image_card():
	if IMAGE_PATH == "":
		return
	var image = load(IMAGE_PATH)
	
	CARD_IMAGE.texture = image

func card_dragging():
	if !SETUP:
		return
	reset_line(TARGET_LINE)
	position = get_global_mouse_position()

func card_targeting():
	if !SETUP:
		return
#	TODO: Check Card Type then determine if it should be a pointer or a floater
	position = OLD_POS
	var pointer = TARGET_LINE.get_node("Pointer")
	
	set_line_points_to_bezier(TARGET_LINE, 
		Vector2(0, -110), 
		Vector2(0, -80), 
		Vector2.ZERO, 
		self.get_local_mouse_position())
	
	pointer.position = TARGET_LINE.points[TARGET_LINE.get_point_count()-1]
	#pointer.position = TARGET_LINE.points[TARGET_LINE.get_point_count() - 4]
	#pointer.look_at(get_global_mouse_position())
	#pointer.rotation_degrees += 90

func focus_card():
	if !SETUP:
		return
	position = OLD_POS
	scale = Vector2(1.2,1.2)
	z_index = 100

func move_to_destination(delta, decktoHand):
	if !SETUP:
		return
	if T <= 1:
		if decktoHand:
			scale = Vector2(T,T)
		position = START_POS.lerp(TARGET_POS, T)
		T += delta/float(DRAW_TIME)
	else:
		scale = Vector2(1,1)
		position = TARGET_POS
		START_POS = TARGET_POS
		STATE = card_enum.CARD_STATE_ENUM.InHand
		z_index = 0
		T = 0
		reset_line(TARGET_LINE)

func focus_in():
	if !SETUP:
		return
	match STATE:
		card_enum.CARD_STATE_ENUM.InHand, card_enum.CARD_STATE_ENUM.ReorganizeHand:
			STATE = card_enum.CARD_STATE_ENUM.FocusInHand

func focus_out():
	if !SETUP:
		return
	match STATE:
		card_enum.CARD_STATE_ENUM.FocusInHand:
			STATE = card_enum.CARD_STATE_ENUM.ReorganizeHand

func reset_line(line: Line2D):
	line.get_node("Pointer").position = Vector2.ZERO
	line.clear_points()

func set_line_points_to_bezier(line: Line2D, a: Vector2, postA: Vector2, preB: Vector2, b: Vector2):
	var curve := Curve2D.new()
	curve.add_point(a, Vector2.ZERO, postA)
	curve.add_point(b, preB, Vector2.ZERO)
	line.points = curve.get_baked_points()
