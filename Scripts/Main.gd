extends Node2D


func _input(event):
	if event.is_action_pressed("1"):
		$PlanterBox.Click()
	elif event.is_action_pressed("2"):
		$PlanterBox2.Click()
	elif event.is_action_pressed("3"):
		$PlanterBox3.Click()
	elif event.is_action_pressed("4"):
		$PlanterBox4.Click()
	elif event.is_action_pressed("5"):
		$PlanterBox5.Click()
	elif event.is_action_pressed("6"):
		$PlanterBox6.Click()
