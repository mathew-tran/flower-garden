extends Node

signal CompleteRound
signal StartNewRound

var CurrentOrder = null

var bHasDoneTutorial = false

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
		file_name = file_name.trim_suffix('.remap')
		var file_path = path + "/" + file_name
		if dir.current_is_dir():
			file_paths += GetAllFilePaths(file_path)
		else:
			file_paths.append(file_path)
		file_name = dir.get_next()
	return file_paths

func SetNewRound():
	randomize()
	if is_instance_valid(CurrentOrder):
		emit_signal("CompleteRound", CurrentOrder)
	await get_tree().create_timer(randf_range(3, 5)).timeout
	var orders = GetAllFilePaths("res://Resources/Orders")
	for order in orders:
		print(order)
	#CurrentOrder = load(orders[randi() % len(orders)]) as PlantOrderResource
	CurrentOrder = load("res://Resources/Orders/Easy/5.tres") as PlantOrderResource
	var boxes = get_tree().get_nodes_in_group("PlanterBox")
	for x in range(0, len(CurrentOrder.flowers)):
		if is_instance_valid(CurrentOrder.flowers[x]):
			boxes[x].SetPlant(CurrentOrder.flowers[x].GetPlantScene())

	emit_signal("StartNewRound", CurrentOrder)

