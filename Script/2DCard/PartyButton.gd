extends TextureButton

@export var MainUi: Node2D

func _on_party_toggled(party_pressed):
	MainUi.visible = party_pressed
	if party_pressed == false:
		MainUi.process_mode = Node.PROCESS_MODE_DISABLED # = Mode: Disabled
	else:
		MainUi.process_mode = Node.PROCESS_MODE_INHERIT # = Mode: Inherit
