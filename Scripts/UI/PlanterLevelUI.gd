extends Control

@onready var LevelText = $VBoxContainer/VBoxContainer/Level
@onready var LevelProgress = $VBoxContainer/ProgressBar

var MaxEXP = 300
func _ready():
	UpdateData()
	Game.GiveXP.connect(OnGiveXP)
	
func OnGiveXP(amount):
	var level = GetLevel()
	var XP = GetEXP()
	XP += amount
	$AnimationPlayer.stop()
	$AnimationPlayer.play("animate")
	while XP >= MaxEXP:
		level += 1
		XP -= MaxEXP
		$AudioStreamPlayer2D.play()
	
	Progression.UpdateKey("LevellingData", {
		"Level" : level,
		"EXP" : XP
	})
	UpdateData()
	
	
func UpdateData():
	LevelText.text = str(GetLevel())	
	LevelProgress.max_value = MaxEXP
	LevelProgress.value = GetEXP()
	
func GetLevel():
	var level = Progression.GetKeyValue("LevellingData")
	if level == null:
		return 0
	else:
		return level["Level"]

func GetEXP():
	var level = Progression.GetKeyValue("LevellingData")
	if level == null:
		return 0
	else:
		return level["EXP"]


func _on_panel_mouse_entered():
	$PlanterInfo.visible = true


func _on_panel_mouse_exited():
		$PlanterInfo.visible = false
