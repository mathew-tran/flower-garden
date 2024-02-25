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
	$HBoxContainer/Level.text = str(PlayerProgression.GetLevelString())


func OnCompleteRound(_x):
	Increment()

func Increment():
	OrdersCompleted += 1
