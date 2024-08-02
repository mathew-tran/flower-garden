extends Node


func GetIcon(type):
	if type == InputManager.INPUT_MODE.WATER:
		return load("res://Art/UI/WaterIcon.svg")
	elif type == InputManager.INPUT_MODE.TEND:
		return load("res://Art/UI/CutIcon.svg")
	elif type == InputManager.INPUT_MODE.MOVE:
		return load("res://Art/UI/MoveIcon.svg")
