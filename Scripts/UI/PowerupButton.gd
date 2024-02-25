extends Button

var Level = 0
var LevelToGoTo = 0

var OwnedColor = Color("ffffff")
var AllocatedColor = Color("8d973a")
var UnOwnedColor = Color("585858")
@export var CategoryName = "test"

@export var PowerUps : Array[LevelPowerUpResource]



func _ready():
	$Label.text = CategoryName
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
		for x in range(Level, LevelToGoTo):
			if is_instance_valid(PowerUps[x]):
				PowerUps[x].ConsumePower()
				PowerUps[x] = null
		Level = LevelToGoTo
		UpdateTicks()

func ResetData():
	LevelToGoTo = Level
	UpdateTicks()

func Increment():
	LevelToGoTo += 1
	UpdateTicks()


func _on_button_down():
	if PlayerProgression.CanAffordSkill() and CanIncrement():
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
