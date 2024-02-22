extends Control

var OrdersCompleted = -1

func _ready():
	Game.connect("CompleteRound", Callable(self, "OnCompleteRound"))

func OnCompleteRound():
	Increment()

func Increment():
	OrdersCompleted += 1
	$HBoxContainer/Text.text = str(OrdersCompleted)
