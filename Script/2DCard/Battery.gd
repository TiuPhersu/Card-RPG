extends Sprite2D

var MAIN_TEXTURE = load("res://Atlas/Battery-Icon.png")

var BATTERY_DICTIONARY = {
	0 : Rect2(0, 0, 32, 32), 
	1 : Rect2(40, 0, 32, 32), 
	2 : Rect2(0, 16, 32,32),
	3 : Rect2(20, 0, 32, 32), 
	4 : Rect2(20, 16, 32, 32),
	5 : Rect2(40, 16, 32, 32),
	6 : Rect2(0, 32, 32, 32)
}

func select_battery(selection):
	texture = AtlasTexture.new()
	texture.set_atlas(MAIN_TEXTURE)
	texture.set_region(BATTERY_DICTIONARY[selection])
#	print(texture.get_region())
