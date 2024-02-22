extends Node

signal CompleteRound
signal StartNewRound

var CurrentOrder = null
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
	if index == 2:
		return "res://Prefabs/Flowers/BlueDaisy.tscn"
	if index == 3:
		return "res://Prefabs/Flowers/PurpleHydrangea.tscn"
	if index == 4:
		return "res://Prefabs/Flowers/YellowDaffodil.tscn"
	if index == 5:
		return "res://Prefabs/Flowers/Dandelion.tscn"
	if index == 6:
		return "res://Prefabs/Flowers/Lavender.tscn"

func SetNewRound():
	randomize()
	if is_instance_valid(CurrentOrder):
		emit_signal("CompleteRound", CurrentOrder)
	await get_tree().create_timer(randf_range(3, 5)).timeout
	var orders = GetAllFilePaths("res://Resources/Orders")
	CurrentOrder = load(orders[randi() % len(orders)])
	var boxes = get_tree().get_nodes_in_group("PlanterBox")
	for x in range(0, len(CurrentOrder.flowers)):
		if CurrentOrder.flowers[x] != -1:
			boxes[x].SetPlant(GetPlant(CurrentOrder.flowers[x]))

	emit_signal("StartNewRound", CurrentOrder)
