extends Node

var FocusedObject = null

enum INPUT_MODE {
	WATER,
	TEND,
	MOVE
}

var CurrentInputMode = INPUT_MODE.WATER

signal ModeChange(newMode)

func ChangeInputMode(newMode):
	CurrentInputMode = newMode
	emit_signal("ModeChange", CurrentInputMode)

func IncrementInputMode():
	if CurrentInputMode == INPUT_MODE.WATER:
		CurrentInputMode = INPUT_MODE.TEND
	elif CurrentInputMode == INPUT_MODE.TEND:
		CurrentInputMode = INPUT_MODE.MOVE
	elif CurrentInputMode == INPUT_MODE.MOVE:
		CurrentInputMode = INPUT_MODE.WATER
	ChangeInputMode(CurrentInputMode)
		
func SetFocusedObject(obj):
	FocusedObject = obj

func _input(event):
	if event.is_action_pressed("mouse_left_click"):
		if is_instance_valid(FocusedObject):
			pass
			#FocusedObject.Click()
