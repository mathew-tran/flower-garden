extends Node

func ArePlanterBoxesCompleted():
	var boxes = get_tree().get_nodes_in_group("PlanterBox")
	for box in boxes:
		if is_instance_valid(box.GetPlant()):
			return false
	return true

func SetNewRound():
	pass
