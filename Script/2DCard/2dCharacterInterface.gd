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

@export var MAX_HEALTH: int:
	get: return MAX_HEALTH
	set(value): MAX_HEALTH = value
	
@export_category("Character Component")
@export var HEALTH_LABEL: Label
@export var HEALTH_BAR: TextureProgressBar
@export var CHARACTER_ICON: Sprite2D
@export var HEART_ICON: Sprite2D

func _ready()  :
	test_health_random()
	CHARACTER_ICON.select_character(CHARACTER_ICON_ENUM)
	HEALTH_LABEL.set_text(str(HEALTH) + "/" + str(MAX_HEALTH))
	var calcHealthPercentage = (float(HEALTH)/float(MAX_HEALTH)) * 100
	print(calcHealthPercentage)
	HEALTH_BAR.set_value_no_signal(0)
	set_heart_icon(calcHealthPercentage)
	set_health_percentage(calcHealthPercentage)

func update_health():
	HEALTH_LABEL.set_text(str(HEALTH) + "/" + str(MAX_HEALTH))
	var calcHealthPercentage = (float(HEALTH)/float(MAX_HEALTH)) * 100
	set_heart_icon(calcHealthPercentage)
	set_health_percentage(calcHealthPercentage)

func set_heart_icon(health_percentage):
	if health_percentage >= 70:
		HEART_ICON.select_heart(0)
	elif health_percentage < 70 && health_percentage > 30:
		HEART_ICON.select_heart(1)
	else:
		HEART_ICON.select_heart(2)

func set_health_percentage(health_percentage):
	var tween = get_tree().create_tween()
	tween.tween_property(HEALTH_BAR,"value", health_percentage, .5).set_trans(Tween.TRANS_LINEAR)
	
func test_health_random():
	var rng = RandomNumberGenerator.new()
	var rngMaxHealth = rng.randi_range(0, 1000)
	var rngCurHealth = rng.randi_range(0, rngMaxHealth)
	
	MAX_HEALTH = rngMaxHealth
	HEALTH = rngCurHealth
