extends Node2D

@export_enum ("Attack", "Skill", "Power", "Innate") var FLOPPY_DISK_ENUM: String
@export_enum ("Empty", "Low", "Medium", "Full", "OverchargeLow", "OverchargeMed", "OverchargeFull") var BATTERY_ENUM: String

# Called when the node enters the scene tree for the first time.
func _ready():
	#self.get_node("Floppy-Disk-Icon").Floppy_Disk_Enum = 1
	self.get_node("Battery-Icon").select_battery(BATTERY_ENUM)
	self.get_node("Floppy-Disk-Icon").select_battery(FLOPPY_DISK_ENUM)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
