extends AnimatedSprite2D

var StageIndex = -1
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

func _process(delta):
	print(StageIndex)

func IncrementStage():
	StageIndex += 1
	if StageIndex < len(get_children()) and StageIndex >= 0:
		GetCurrentStage().StartStage()
	if StageIndex == len(get_children()):
		StageIndex =  len(get_children()) - 1

func IsCompleted():
	return StageIndex == len(get_children()) - 1
