extends Camera3D

var mouse = Vector2()

func get_selection(mousePosition):
	var worldspace = get_world_3d().direct_space_state
	var start = project_ray_origin(mousePosition)
	var end = project_position(mousePosition, 1000)
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	if !result.is_empty() and result.collider.is_in_group("Characters"):
		print("Ally:")
		print(result)
		return result

	if !result.is_empty() and result.collider.is_in_group("Enemies"):
		print("Enemy:")
		print(result)
		return result
