extends Button

var Level = 2
var LevelToGoTo = 0

@export var OwnedColor : Color
@export var AllocatedColor : Color
@export var UnOwnedColor : Color

func _ready():
	UpdateTicks()
	LevelToGoTo = Level
	PlayerProgression.connect("SkillsReset", Callable(self, "OnSkillsReset"))
	PlayerProgression.connect("SkillsCompleteTransaction", Callable(self, "OnSkillsCompleteTransaction"))

func OnSkillsReset():
	ResetData()

func OnSkillsCompleteTransaction():
	SetData()

func GivePowerup():
	PlayerProgression.BroadcastPowerUpSelected()

func SetData():
	if Level != LevelToGoTo:
		Level = LevelToGoTo
		UpdateTicks()

func ResetData():
	LevelToGoTo = Level
	UpdateTicks()

func Increment():
	LevelToGoTo += 1
	UpdateTicks()


func _on_button_down():
	if PlayerProgression.CanAffordSkill():
		Increment()
		PlayerProgression.UseAllocatedSkillPoint()

func CanIncrement():
	return LevelToGoTo < len($HBoxContainer.get_children())

func UpdateTicks():
	for index in range(0, len($HBoxContainer.get_children())):
		if index < Level:
			$HBoxContainer.get_child(index).modulate = OwnedColor
		elif index < LevelToGoTo:
			$HBoxContainer.get_child(index).modulate = AllocatedColor
		else:
			$HBoxContainer.get_child(index).modulate = UnOwnedColor
