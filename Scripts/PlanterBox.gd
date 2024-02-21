extends AnimatedSprite2D


var bIsHovered = false


func _on_area_2d_mouse_entered():
	InputManager.SetFocusedObject(self)


func _on_area_2d_mouse_exited():
	InputManager.SetFocusedObject(null)

func Click():
	print(name + " has been clicked")
	GetPlant().AttemptGrow()

func GetPlant():
	return $Flower


func _on_timer_timeout():
	$TextureProgressBar.visible = false
	if is_instance_valid(GetPlant()):
		if GetPlant().IsCompleted() == false:
			$TextureProgressBar.visible = true
			$TextureProgressBar.value = GetPlant().GetCurrentStage().GetTimeLeft()
			$TextureProgressBar.max_value = GetPlant().GetCurrentStage().GetMaxTime()

