extends Control

func _ready():
	PlayerProgression.connect("PowerUpSelected", Callable(self, "OnPowerUpSelected"))
	PlayerProgression.connect("LevelUpdate", Callable(self, "OnLevelUp"))
	PlayerProgression.connect("SkillPointAllocated", Callable(self, "OnSkillPointAllocated"))

func OnLevelUp():
	EnableButtons(false)
	visible = true
	await get_tree().create_timer(1).timeout
	EnableButtons(true)
	$Panel/VBoxContainer/HBoxContainer.get_child(0).grab_focus()

func OnPowerUpSelected():
	visible = false
	$Panel/VBoxContainer/HBoxContainer2.visible = true
	$Panel/VBoxContainer/SkillPointsRemaining.visible = true

func _on_visibility_changed():
	get_tree().paused = visible
	OnSkillPointAllocated()

func EnableButtons(bEnable):
	for button in $Panel/VBoxContainer/HBoxContainer.get_children():
		button.disabled = !bEnable

func OnSkillPointAllocated():
	var points = PlayerProgression.AllocatedSkillPoints
	$Panel/VBoxContainer/SkillPointsRemaining.text = str(points) + " Skill points remaining"
	if points > 0:
		$Panel/VBoxContainer/SkillPointsRemaining.modulate = Color.RED
		$Panel/VBoxContainer/HBoxContainer2/AcceptButton.disabled = true
	else:
		$Panel/VBoxContainer/SkillPointsRemaining.modulate = Color.WHITE
		$Panel/VBoxContainer/HBoxContainer2/AcceptButton.disabled = false


func _on_accept_button_button_up():
	$Panel/VBoxContainer/HBoxContainer2.visible = false
	$Panel/VBoxContainer/SkillPointsRemaining.visible = false
	PlayerProgression.CompleteSkillTransaction()
	await get_tree().create_timer(1).timeout
	PlayerProgression.BroadcastPowerUpSelected()


func _on_reject_button_button_up():
	PlayerProgression.ResetAllocatedSkillPoints()

