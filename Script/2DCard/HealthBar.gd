extends TextureProgressBar

@export var HEALTH: int:
	get: return HEALTH
	set(value): HEALTH = value

@export var MAX_HEALTH: int:
	get: return MAX_HEALTH
	set(value): MAX_HEALTH = value

@onready var TIMER = self.get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	TIMER.start()

func _on_timer_timeout():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.value
