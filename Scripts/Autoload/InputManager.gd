extends Node

var FocusedObject = null

enum INPUT_MODE {
	WATER,
	TEND,
	CUT
}

var CurrentInputMode = INPUT_MODE.WATER

func SetFocusedObject(obj):
	FocusedObject = obj

func _input(event):
	if event.is_action_pressed("mouse_left_click"):
		if is_instance_valid(FocusedObject):
			FocusedObject.Click()
