extends CustomButton



func _on_button_up():
	if Game.bHasDoneTutorial:
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Tutorial.tscn")
		Game.bHasDoneTutorial = true
