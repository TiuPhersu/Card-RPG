extends Sprite2D

var MAIN_TEXTURE = load("res://Atlas/Character-Icon.png")

var CHARACTER_DICTIONARY = {
	0 : Rect2(0, 0, 19, 19), 
	1 : Rect2(0, 20, 19, 19)
}

func select_character(selection):
	texture = AtlasTexture.new()
	texture.set_atlas(MAIN_TEXTURE)
	texture.set_region(CHARACTER_DICTIONARY[selection])
#	print(texture.get_region())
