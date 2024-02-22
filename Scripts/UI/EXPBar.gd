extends Control

var OrdersCompleted = 0

func _ready():
	Game.connect("CompleteRound", Callable(self, "OnCompleteRound"))

func OnCompleteRound(_x):
	Increment()

func Increment():
	OrdersCompleted += 1
	$HBoxContainer/Text.text = str(OrdersCompleted)
