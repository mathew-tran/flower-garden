extends Control

func _ready():
	PlayerProgression.connect("PowerUpSelected", Callable(self, "OnPowerUpSelected"))
	PlayerProgression.connect("LevelUpdate", Callable(self, "OnLevelUp"))

func OnLevelUp():
	visible = true
	$Panel/VBoxContainer/HBoxContainer.get_child(0).grab_focus()

func OnPowerUpSelected():
	visible = false
