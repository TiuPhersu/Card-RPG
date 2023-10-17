extends TextureButton

@export var MainUi: Node2D

func _on_file_toggled(file_pressed):
	MainUi.visible = file_pressed
	if file_pressed == false:
		MainUi.process_mode = Node.PROCESS_MODE_DISABLED # = Mode: Disabled
	else:
		MainUi.process_mode = Node.PROCESS_MODE_INHERIT # = Mode: Inherit
