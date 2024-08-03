extends HBoxContainer

func _on_water_icon_button_up():
	InputManager.ChangeInputMode(InputManager.INPUT_MODE.WATER)
	$WaterIcon.grab_focus()

func _on_tend_icon_button_up():
	InputManager.ChangeInputMode(InputManager.INPUT_MODE.TEND)
	$TendIcon.grab_focus()

func _on_move_icon_button_up():
	InputManager.ChangeInputMode(InputManager.INPUT_MODE.MOVE)
	$MoveIcon.grab_focus()

func Animate():
	pass
	
func _input(event):
	if event.is_action_pressed("f1"):
		_on_water_icon_button_up()
	elif event.is_action_pressed("f2"):
		_on_tend_icon_button_up()
	elif event.is_action_pressed("f3"):
		_on_move_icon_button_up()
	if Input.is_action_just_pressed("mouse_right_click"):
		InputManager.IncrementInputMode()
