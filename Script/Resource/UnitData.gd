extends Resource

class_name unit_data

@export var UNIT_NAME: String
@export var CHARACTER_ICON: String

@export var UNIT_LEVEL: int

# STAT APTITUDE 
# It's represented as a percentage, 
# and it acts as a multiplier to the 
# stats gained from levels 
# (increasing them if above 100%, 
# decreasing them if below).

# Use RADAR CHART for Stat Display
# https://github.com/tbpaksoy/Godot-Chart-Implementation/blob/main/RadarChart.cs
# F=Below 100, D=100-200, C=200-300, B=300-400, A=400-500, S=500-600, Incalculatable=Above 600
# X25 is Minus (-), X75 is Plus (+)
@export var BASE_CONSTITUTION: int #Health
@export var BASE_STRENGTH: int #Physical Damage, Self Buffs, Charge, Discard More Power
@export var BASE_DEXTERITY: int #Card Cost, Draw Power, Multihit, Hand Manipulation
@export var BASE_INTELLIGENCE: int #Magic Damage, Scry, Deck Manipulation
@export var BASE_WILLPOWER: int #Block, Resistance, Defense related abilities
@export var BASE_LUCK: int #Random target, random damage, any chance based ability

@export var ADDITIONAL_CONSTITUTION: int 
@export var ADDITIONAL_STRENGTH: int 
@export var ADDITIONAL_DEXTERITY: int 
@export var ADDITIONAL_INTELLIGENCE: int 
@export var ADDITIONAL_WILLPOWER: int 
@export var ADDITIONAL_LUCK: int 

@export var DECK: Array[card_data] = []
