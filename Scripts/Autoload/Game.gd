extends Node

signal CompleteRound

func ArePlanterBoxesCompleted():
	var boxes = get_tree().get_nodes_in_group("PlanterBox")
	for box in boxes:
		if is_instance_valid(box.GetPlant()):
			return false
	return true

func GetAllFilePaths(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		var file_path = path + "/" + file_name
		if dir.current_is_dir():
			file_paths += GetAllFilePaths(file_path)
		else:
			file_paths.append(file_path)
		file_name = dir.get_next()
	return file_paths


func GetPlant(index):
	if index == 0:
		return "res://Prefabs/Flowers/Rose.tscn"
	if index == 1:
		return "res://Prefabs/Flowers/SimpleRose.tscn"

func SetNewRound():
	emit_signal("CompleteRound")

	var orders = GetAllFilePaths("res://Resources/Orders")
	var order = load(orders[randi() % len(orders)])
	var boxes = get_tree().get_nodes_in_group("PlanterBox")
	for x in range(0, len(order.flowers)):
		if order.flowers[x] != -1:
			boxes[x].SetPlant(GetPlant(order.flowers[x]))
