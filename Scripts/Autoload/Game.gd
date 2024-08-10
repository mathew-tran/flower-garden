extends Node

signal CompleteRound
signal StartNewRound
signal NewFlowerFound
var CurrentOrder = null

var bHasDoneTutorial = false

func ArePlanterBoxesCompleted():
	var boxes = get_tree().get_nodes_in_group("PlanterBox")
	for box in boxes:
		if is_instance_valid(box.GetPlant()):
			return false
	return true



func SetNewRound():
	randomize()
	if is_instance_valid(CurrentOrder):
		emit_signal("CompleteRound", CurrentOrder)
	await get_tree().create_timer(randf_range(3, 5)).timeout
	var orders = Helper.GetAllFilePaths("res://Resources/Orders")
	for order in orders:
		print(order)
	CurrentOrder = load(orders[randi() % len(orders)]) as PlantOrderResource
	#CurrentOrder = load("res://Resources/Orders/Easy/5.tres") as PlantOrderResource
	var boxes = get_tree().get_nodes_in_group("PlanterBox")
	for x in range(0, len(CurrentOrder.flowers)):
		if is_instance_valid(CurrentOrder.flowers[x]):
			boxes[x].SetPlant(CurrentOrder.flowers[x])

	emit_signal("StartNewRound", CurrentOrder)

