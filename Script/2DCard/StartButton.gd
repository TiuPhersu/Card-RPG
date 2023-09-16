extends TextureButton

@export var MainUi: Node2D

func _on_start_toggled(start_pressed):
	MainUi.visible = start_pressed
	if start_pressed == false:
		MainUi.process_mode = Node.PROCESS_MODE_DISABLED # = Mode: Disabled
	else:
		MainUi.process_mode = Node.PROCESS_MODE_INHERIT # = Mode: Inherit
