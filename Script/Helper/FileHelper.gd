extends Node

class_name file_helper

func list_files_in_directory(path):
	var files = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	if files.is_empty():
		files.append("No Cards Found")
	return files

func save_single_card_resource(cardResource:card_data, path:String, oldPath):
	if oldPath != null:
		DirAccess.remove_absolute(oldPath)
	
	# TODO : CHECK IF CARD EXISTS
	if cardResource is card_data: # Check if it is type Resource CARD_DATA
		ResourceSaver.save(cardResource, path)
		print("Card " + cardResource.TITLE + " has been saved")
	else:
		print("Data is not of type CARD_DATA")
	
func load_single_card_resource(path) -> card_data:
	var cardResource = load(path)
	if not cardResource: # Check if exist
		cardResource = card_data.new()
	
	return cardResource

func delete_single_card_resource(path):
	DirAccess.remove_absolute(path)
