extends Control

func _ready():
	add_to_group("Message")

	Game.connect("CompleteRound", Callable(self, "OnCompleteRound"))
	Game.connect("StartNewRound", Callable(self, "OnStartNewRound"))
	visible = false

func OnCompleteRound(order):
	SetMessage(order.thanks)

func OnStartNewRound(order):
	SetMessage(order.greeting)


func SetMessage(message):
	visible = false
	$Label.text = message
	$AnimationPlayer.play("animate")
	visible = true
