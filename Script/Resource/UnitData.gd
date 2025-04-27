extends Resource

class_name unit_data

@export var UNIT_NAME: String
@export var CHARACTER_ICON: String

@export var UNIT_LEVEL: int
@export var UNIT_HEALTH: int
@export var UNIT_EXPERIENCE: int

# STAT APTITUDE 
# It's represented as a percentage, 
# and it acts as a multiplier to the 
# stats gained from levels 
# (increasing them if above 100%, 
# decreasing them if below).

# Use RADAR CHART for Stat Display
# https://github.com/tbpaksoy/Godot-Chart-Implementation/blob/main/RadarChart.cs
# F=Below 20, D=20-40, C=40-60, B=60-80, A=Above 80
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
