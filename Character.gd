extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var facing

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		update_facing(input_dir)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func update_facing(input_dir):
	# Face away from camera
	if input_dir == Vector2(0,-1):
		print(input_dir)
		anim_tree.set("parameters/Walk/blend_position", Vector2(0, 1))
		anim_state.travel("Walk")
	# Face toward camera
	if input_dir == Vector2(0,1):
		print(input_dir)
		anim_tree.set("parameters/Walk/blend_position", Vector2(0, -1))
		anim_state.travel("Walk")
	# Face right
	if input_dir == Vector2(1,0):
		print(input_dir)
		anim_tree.set("parameters/Walk/blend_position", Vector2(1, 0))
		anim_state.travel("Walk")
	# Face Left
	if input_dir == Vector2(-1,0):
		print(input_dir)
		anim_tree.set("parameters/Walk/blend_position", Vector2(-1, 0))
		anim_state.travel("Walk")
		
	# 8 Direction
	# Face Southeast
	if input_dir.x > 0 and input_dir.y > 0:
		print(input_dir)
		anim_tree.set("parameters/Walk/blend_position", Vector2(1, -1))
		anim_state.travel("Walk")
	# Face Southwest
	if input_dir.x < 0 and input_dir.y > 0:
		print(input_dir)
		anim_tree.set("parameters/Walk/blend_position", Vector2(-1, -1))
		anim_state.travel("Walk")
	# Face Northeast
	if input_dir.x > 0 and input_dir.y < 0:
		print(input_dir)
		anim_tree.set("parameters/Walk/blend_position", Vector2(1, 1))
		anim_state.travel("Walk")
	# Face Northwest
	if input_dir.x < 0 and input_dir.y < 0:
		print(input_dir)
		anim_tree.set("parameters/Walk/blend_position", Vector2(-1, 1))
		anim_state.travel("Walk")
