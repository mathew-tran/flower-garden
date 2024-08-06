extends CustomButton



func _on_button_up():
	$AudioStreamPlayer2D.play()
	self_modulate = Color.DARK_GRAY
	disabled = true

func _on_audio_stream_player_2d_finished():
	if Game.bHasDoneTutorial:
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Tutorial.tscn")
		Game.bHasDoneTutorial = true
