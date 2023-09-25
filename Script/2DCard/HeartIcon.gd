extends Sprite2D

var MAIN_TEXTURE = load("res://Atlas/Heart-Icon.png")

var HEART_DICTIONARY = {
	0 : Rect2(0, 0, 19, 19), 
	1 : Rect2(0, 40, 19, 19), 
	2 : Rect2(0, 20, 19, 19)
}

func select_heart(selection):
	texture = AtlasTexture.new()
	texture.set_atlas(MAIN_TEXTURE)
	texture.set_region(HEART_DICTIONARY[selection])
#	print(texture.get_region())
