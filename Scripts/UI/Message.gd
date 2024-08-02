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
	$Label.visible_ratio = 0
	$AnimationPlayer.play("animate")
	visible = true
	var tween = get_tree().create_tween()
	tween.tween_property($Label, "visible_ratio", 1, 1)
