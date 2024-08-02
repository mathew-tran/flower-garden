extends Node2D


func _ready():
	HideHint()

func SetHint(type):
	visible = true
	$TextureRect.texture = Definitions.GetIcon(type)

	$AnimationPlayer.play("animate")

func HideHint():
	visible = false

