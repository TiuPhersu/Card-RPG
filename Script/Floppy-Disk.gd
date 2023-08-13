extends Sprite2D

var MAIN_TEXTURE = load("res://Atlas/Floppy-Disk-Icon.png")


var FLOPPY_DISK_DICTIONARY = {
	"Attack": Rect2(0, 0,32,32), 
	"Skill": Rect2(24, 24, 32,32), 
	"Power" : Rect2(0, 24, 32,32), 
	"Innate" : Rect2(24, 0, 32,32)
}

func select_battery(selection):
	texture = AtlasTexture.new()
	texture.set_atlas(MAIN_TEXTURE)
	texture.set_region(FLOPPY_DISK_DICTIONARY[selection])
	print(texture.get_region())

# Called when the node enters the scene tree for the first time.
#func _ready():
#	print(FLOPPY_DISK_ENUM)
#	texture = AtlasTexture.new()
#	texture.set_atlas(MAIN_TEXTURE)
#	texture.set_region(FLOPPY_DISK_DICTIONARY[FLOPPY_DISK_ENUM])
#	print(texture.get_region())
