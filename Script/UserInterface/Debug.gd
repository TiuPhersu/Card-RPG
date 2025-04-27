extends Node2D

@onready var FRAME_COUNTER = self.get_node("FrameRateLabel")

const TIMER_LIMIT = 2.0
var timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var counter;
	timer += delta
	if timer > TIMER_LIMIT: # Prints every 2 seconds
		timer = 0.0
		counter = "FPS Counter: " + str(Engine.get_frames_per_second())
		FRAME_COUNTER.text = counter
	pass
