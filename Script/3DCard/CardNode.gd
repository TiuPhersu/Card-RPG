extends Node3D

@onready var anim = $AnimationPlayer

func _ready():
	anim.play("Pointer")

func show_animation():
	get_node("Sprite3D").show()

func hide_animation():
	get_node("Sprite3D").hide()
