extends Control

var OrdersCompleted = 0

func _ready():
	Game.connect("CompleteRound", Callable(self, "OnCompleteRound"))
	PlayerProgression.connect("EXPUpdate", Callable(self, "OnUpdateXP"))
	PlayerProgression.connect("LevelUpdate", Callable(self, "OnLevelUpdate"))

	OnUpdateXP()
	OnLevelUpdate()

func OnUpdateXP():
	$ProgressBar.value = PlayerProgression.GetEXP()

func OnLevelUpdate():
	$ProgressBar.max_value = PlayerProgression.GetMaxEXP()
	var amount = 0
	var maxValue = PlayerProgression.GetMaxEXP()
	while maxValue > 0:
		maxValue -= 20
		amount += 1
	$HSlider.tick_count = amount
	$HBoxContainer/Level.text = str(PlayerProgression.GetLevelString())


func OnCompleteRound(_x):
	Increment()

func Increment():
	OrdersCompleted += 1
