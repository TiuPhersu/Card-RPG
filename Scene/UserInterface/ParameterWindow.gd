extends NinePatchRect

@export var UNIT_DATA: Resource

@onready var CON_LBL = self.get_node("Constitution/UnitStat")
@onready var STR_LBL = self.get_node("Strength/UnitStat")
@onready var DEX_LBL = self.get_node("Dexterity/UnitStat")
@onready var INT_LBL = self.get_node("Intelligence/UnitStat")
@onready var WIL_LBL = self.get_node("Willpower/UnitStat")
@onready var LUK_LVL = self.get_node("Luck/UnitStat")

func set_unit_data(set_unit):
	UNIT_DATA = set_unit
	setup()


func setup():
	CON_LBL.text = str(UNIT_DATA.UNIT_LEVEL * (UNIT_DATA.BASE_CONSTITUTION + UNIT_DATA.ADDITIONAL_CONSTITUTION))
	STR_LBL.text = str(UNIT_DATA.UNIT_LEVEL * (UNIT_DATA.BASE_STRENGTH + UNIT_DATA.ADDITIONAL_STRENGTH))
	DEX_LBL.text = str(UNIT_DATA.UNIT_LEVEL * (UNIT_DATA.BASE_DEXTERITY + UNIT_DATA.ADDITIONAL_DEXTERITY))
	INT_LBL.text = str(UNIT_DATA.UNIT_LEVEL * (UNIT_DATA.BASE_INTELLIGENCE + UNIT_DATA.ADDITIONAL_INTELLIGENCE))
	WIL_LBL.text = str(UNIT_DATA.UNIT_LEVEL * (UNIT_DATA.BASE_WILLPOWER + UNIT_DATA.ADDITIONAL_WILLPOWER))
	LUK_LVL.text = str(UNIT_DATA.UNIT_LEVEL * (UNIT_DATA.BASE_LUCK + UNIT_DATA.ADDITIONAL_LUCK))
	pass
