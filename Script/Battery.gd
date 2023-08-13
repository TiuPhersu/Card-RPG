extends Sprite2D

var MAIN_TEXTURE = load("res://Atlas/Battery-Icon.png")


var BATTERY_DICTIONARY = {
	"Empty": Rect2(0, 0, 32, 32), 
	"Full": Rect2(20, 0, 32, 32), 
	"Low" : Rect2(40, 0, 32, 32), 
	"Medium" : Rect2(0, 16, 32,32),
	"OverchargeLow": Rect2(20, 16, 32, 32),
	"OverchargeMed": Rect2(40, 16, 32, 32),
	"OverchargeFull": Rect2(0, 32, 32, 32)
}

func select_battery(selection):
	texture = AtlasTexture.new()
	texture.set_atlas(MAIN_TEXTURE)
	texture.set_region(BATTERY_DICTIONARY[selection])
	print(texture.get_region())

# Called when the node enters the scene tree for the first time.
#func _ready():
#	print(BATTERY_ENUM)
#	texture = AtlasTexture.new()
#	texture.set_atlas(MAIN_TEXTURE)
#	texture.set_region(BATTERY_DICTIONARY[BATTERY_ENUM])
#	print(texture.get_region())
