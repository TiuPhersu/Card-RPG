extends Control

const LOADING_SCENE_PATH = "res://Scene/UserInterface/LoadScreen.tscn"

func _on_pressed():
	print("Starting game")
	get_tree().change_scene_to_file(LOADING_SCENE_PATH)
