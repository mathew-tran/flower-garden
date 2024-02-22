extends AnimatedSprite2D

var StageIndex = -1

signal UpdateGrowth
signal FinishGrowth

func _ready():
	IncrementStage()

func GetCurrentStage():
	return get_child(StageIndex)

func AttemptGrow():
	if IsCompleted():
		return

	if GetCurrentStage().CanActivate():
		var frameCount =  sprite_frames.get_frame_count("grow")
		if frame < frameCount:
			frame += 1
		IncrementStage()
	else:
		print("failed to activate")


func IncrementStage():
	StageIndex += 1
	emit_signal("FinishGrowth")

	if StageIndex < len(get_children()) - 1 and StageIndex >= 0:
		GetCurrentStage().StartStage()
		GetCurrentStage().connect("StageComplete", Callable(self, "OnCompleteStage"))

	if StageIndex == len(get_children()):
		StageIndex =  len(get_children()) - 1

func OnCompleteStage():
	emit_signal("UpdateGrowth", GetCurrentStage().GetInputNeeded())

func IsCompleted():
	return StageIndex == len(get_children()) - 1
