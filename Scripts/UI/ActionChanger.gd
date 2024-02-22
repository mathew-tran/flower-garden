extends VBoxContainer

func _on_water_icon_button_up():
	InputManager.ChangeInputMode(InputManager.INPUT_MODE.WATER)

func _on_tend_icon_button_up():
	InputManager.ChangeInputMode(InputManager.INPUT_MODE.TEND)

func _on_move_icon_button_up():
	InputManager.ChangeInputMode(InputManager.INPUT_MODE.MOVE)
