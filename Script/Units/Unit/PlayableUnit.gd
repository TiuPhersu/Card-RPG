extends CharacterBody3D
class_name PlayableUnit

@export var UNIT_DATA:Resource

@onready var FILE_HELPER = file_helper.new()

var UNIT_LIST: Array

func _ready():
	UNIT_LIST = FILE_HELPER.list_files_in_directory("res://Data/Units/")
	load_unit_data()
	add_to_group("Playable")

func load_unit_data() -> void:
	var unitName = self.name
	var unitData = FILE_HELPER.load_single_unit_resource("res://Data/Units/" + unitName + ".tres")
	if unitData == null:
		print("There is no data for this unit. Please create unit data for " + unitName + ".")
	UNIT_DATA = unitData

func inflict_status(_event) -> void:
	pass

func inflict_damage(_event) -> void:
	pass
