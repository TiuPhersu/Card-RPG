extends NinePatchRect

@export var UNIT_DATA: Resource

@onready var NAME_LBL = self.get_node("Name/UnitName")
@onready var LVL_LBL = self.get_node("Level/UnitLevel")
@onready var HP_LBL = self.get_node("Health/HealthLabel")
@onready var HP_BAR = self.get_node("Health/HealthBar")
@onready var EXP_LBL = self.get_node("Experience/ExperienceLabel")
@onready var EXP_BAR = self.get_node("Experience/ExperienceProgressBar")
#@onready var TWEEN = get_tree().create_tween()

var MAX_HEALTH = 0
var MAX_EXP = 100

func set_unit_data(set_unit):
	UNIT_DATA = set_unit
	setup()

func setup():
	NAME_LBL.text = UNIT_DATA.UNIT_NAME
	LVL_LBL.text = str(UNIT_DATA.UNIT_LEVEL)
	set_health()
	set_exp()

func set_health():
	MAX_HEALTH = UNIT_DATA.UNIT_LEVEL * (UNIT_DATA.BASE_CONSTITUTION + UNIT_DATA.ADDITIONAL_CONSTITUTION)
	HP_LBL.set_text(str(UNIT_DATA.UNIT_HEALTH) + "/" + str(MAX_HEALTH))
	var calcHealthPercentage = (float(UNIT_DATA.UNIT_HEALTH)/float(MAX_HEALTH)) * 100
	HP_BAR.value = calcHealthPercentage
#	set_health_percentage(calcHealthPercentage)

#func set_health_percentage(health_percentage):
#	TWEEN.tween_property(HP_BAR,"value", health_percentage, .5).set_trans(Tween.TRANS_LINEAR)
	
func set_exp():
	EXP_LBL.set_text(str(UNIT_DATA.UNIT_EXPERIENCE) + "/" + str(MAX_EXP))
	var calcExpPercentage = (float(UNIT_DATA.UNIT_EXPERIENCE)/float(MAX_EXP)) * 100
	EXP_BAR.value = calcExpPercentage
#	set_exp_percentage(calcExpPercentage)

#func set_exp_percentage(exp_percentage):
#	TWEEN.tween_property(EXP_BAR,"value", exp_percentage, .5).set_trans(Tween.TRANS_LINEAR)
