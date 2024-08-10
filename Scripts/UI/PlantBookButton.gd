extends Button

var AmountToShake = 5
func _ready():
	Game.NewFlowerFound.connect(OnNewFlowerFound)

func OnNewFlowerFound():
	$AnimationPlayer.play("animate")


func _on_animation_player_animation_finished(anim_name):
	AmountToShake -= 1
	if AmountToShake > 0:
		$AnimationPlayer.play("animate")
	else:
		AmountToShake = 5


func _on_animation_player_animation_started(anim_name):
	$AudioStreamPlayer2D.play()
