extends Node2D


@export var TimeToWait = 2.0
@export var ModeToUse : InputManager.INPUT_MODE

var StageTimer

signal StageComplete

func StartStage():
	StageTimer = Timer.new()
	StageTimer.wait_time = TimeToWait
	StageTimer.one_shot = true
	add_child(StageTimer)
	StageTimer.start()
	StageTimer.connect("timeout", Callable(self, "OnTimeout"))

func OnTimeout():
	emit_signal("StageComplete")

func CleanStage():
	if is_instance_valid(StageTimer):
		StageTimer.queue_free()

func CanActivate():
	if is_instance_valid(StageTimer):
		return StageTimer.time_left == 0.0 and InputManager.CurrentInputMode == ModeToUse
	return false

func GetInputNeeded():
	return ModeToUse

func GetTimeLeft():
	if is_instance_valid(StageTimer):
		return StageTimer.time_left
	return 0

func GetMaxTime():
	return StageTimer.wait_time
