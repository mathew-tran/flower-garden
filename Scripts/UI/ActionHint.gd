extends Node2D


func _ready():
	HideHint()

func SetHint(type):
	visible = true
	if type == InputManager.INPUT_MODE.WATER:
		$TextureRect.texture = load("res://Art/UI/WaterIcon.png")
	elif type == InputManager.INPUT_MODE.TEND:
		$TextureRect.texture = load("res://Art/UI/TendIcon.png")
	elif type == InputManager.INPUT_MODE.MOVE:
		$TextureRect.texture = load("res://Art/UI/MoveIcon.png")
	$AnimationPlayer.play("animate")

func HideHint():
	visible = false

