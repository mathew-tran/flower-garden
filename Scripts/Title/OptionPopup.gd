extends Panel

var bDoublePress = false

func _on_close_button_button_up():
	visible = false


func _on_delete_data_button_up():
	if bDoublePress == false:
		bDoublePress = true
		$"Delete Data".text = "Press one more time to delete data"
		$Timer.start()
		return
	Progression.ClearData()
	get_tree().reload_current_scene()


func _on_timer_timeout():
	$"Delete Data".text = "Delete Data"
	bDoublePress = false
