extends Control


@onready var BackButton = $HBoxContainer/BackButton
@onready var ContinueButton = $HBoxContainer/ContinueButton
@onready var Content = $TabContainer

func _ready():
	UpdateButtons()

func UpdateButtons():
	
	BackButton.disabled = $TabContainer.current_tab == 0
	if $TabContainer.current_tab == len($TabContainer.get_children()) -1:
		ContinueButton.text = "Start"
	else:
		ContinueButton.text = "Continue"
	await get_tree().create_timer(.1).timeout
	ContinueButton.release_focus()
	BackButton.release_focus()

func _on_back_button_button_up():
	$TabContainer.current_tab -= 1
	UpdateButtons()
	$SFX.play()



func _on_continue_button_button_up():
	if $TabContainer.current_tab == len($TabContainer.get_children()) - 1:
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
		return
	else:
		$TabContainer.current_tab += 1
		UpdateButtons()
	$SFX.play()

