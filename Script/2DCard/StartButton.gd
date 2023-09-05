extends TextureButton

@export var MainUi: Node2D

func _on_toggled(button_pressed):
	MainUi.visible = button_pressed
	if button_pressed == false:
		MainUi.process_mode = 4 # = Mode: Disabled
	else:
		MainUi.process_mode = 0 # = Mode: Inherit
