extends Control

func _ready():
	PlayerProgression.connect("PowerUpSelected", Callable(self, "OnPowerUpSelected"))
	PlayerProgression.connect("LevelUpdate", Callable(self, "OnLevelUp"))

func OnLevelUp():
	EnableButtons(false)
	visible = true
	await get_tree().create_timer(1).timeout
	EnableButtons(true)
	$Panel/VBoxContainer/HBoxContainer.get_child(0).grab_focus()

func OnPowerUpSelected():
	visible = false


func _on_visibility_changed():
	get_tree().paused = visible

func EnableButtons(bEnable):
	for button in $Panel/VBoxContainer/HBoxContainer.get_children():
		button.disabled = !bEnable
