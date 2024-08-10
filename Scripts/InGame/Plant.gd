extends AnimatedSprite2D

var StageIndex = -1

signal UpdateGrowth
signal FinishGrowth
signal Completed

func _ready():
	if randi() % 2 == 1:
		scale.x = -1
	IncrementStage()

func GetCurrentStage():
	return get_child(StageIndex)

func AttemptGrow():
	if IsCompleted():
		return

	if GetCurrentStage().CanActivate():
		if GetCurrentStage().ShouldIncreaseFrame():
			var frameCount =  sprite_frames.get_frame_count("grow")
			if frame < frameCount:
				frame += 1
		IncrementStage()
		Game.GiveXP.emit(2 + randi_range(2, 4))

	else:
		print("failed to activate")


func IncrementStage():
	if StageIndex != -1:
		GetCurrentStage().CleanStage()
	StageIndex += 1
	emit_signal("FinishGrowth")

	if StageIndex <= len(get_children()) - 1 and StageIndex >= 0:
		GetCurrentStage().StartStage()
		GetCurrentStage().connect("StageComplete", Callable(self, "OnCompleteStage"))
	elif StageIndex >= len(get_children()) - 1:
		emit_signal("Completed")



func OnCompleteStage():
	emit_signal("UpdateGrowth", GetCurrentStage().GetInputNeeded())
	var animateTween = get_tree().create_tween()
	animateTween.tween_property(self, "rotation_degrees", -15, .1)
	await animateTween.finished
	animateTween = get_tree().create_tween()
	animateTween.tween_property(self, "rotation_degrees", 15, .1)
	await animateTween.finished
	animateTween = get_tree().create_tween()
	animateTween.tween_property(self, "rotation_degrees", 0, .1)

func IsCompleted():
	return StageIndex == len(get_children())
