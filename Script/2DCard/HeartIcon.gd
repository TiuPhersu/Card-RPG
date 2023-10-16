extends Sprite2D

var MAIN_TEXTURE = load("res://Atlas/Heart-Icon.png")

var HEART_DICTIONARY = {
	0 : Rect2(0, -1, 20, 20), 
	1 : Rect2(0, 39, 20, 20), 
	2 : Rect2(0, 19, 20, 20)
}

func select_heart(selection):
	texture = AtlasTexture.new()
	texture.set_atlas(MAIN_TEXTURE)
	texture.set_region(HEART_DICTIONARY[selection])
#	print(texture.get_region())
