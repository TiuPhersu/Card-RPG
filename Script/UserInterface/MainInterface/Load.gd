extends Control

var LOADING_STATUS: int
var PROGRESS: Array[float]

@export var TARGET_SCENE_PATH = "res://Scene/2d/2dCombatArea.tscn"
@onready var LOAD_PROGRESS_BAR = self.get_node("Progress/LoadProgressBar")

func _ready():
	ResourceLoader.load_threaded_request(TARGET_SCENE_PATH)

func _process(_delta: float):
	# Update the status:
	LOADING_STATUS = ResourceLoader.load_threaded_get_status(TARGET_SCENE_PATH, PROGRESS)
	
	# Check the loading status:
	match LOADING_STATUS:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			LOAD_PROGRESS_BAR.set_value_no_signal(PROGRESS[0] * 100) # Change the ProgressBar value
#			print(PROGRESS.size())
		ResourceLoader.THREAD_LOAD_LOADED:
			# When done loading, change to the target scene:
			LOAD_PROGRESS_BAR.set_value_no_signal(PROGRESS[0] * 100) # Change the ProgressBar value
			await get_tree().create_timer(0.1).timeout
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(TARGET_SCENE_PATH))
		ResourceLoader.THREAD_LOAD_FAILED:
			# Well some error happend:
			print("Error. Could not load Resource")
	
