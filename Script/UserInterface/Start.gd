extends Control

const LOADING_SCENE_PATH = "res://Scene/UserInterface/LoadScreen.tscn"

func _on_button_pressed() -> void:
	print("test")
	get_tree().change_scene_to_file(LOADING_SCENE_PATH)
