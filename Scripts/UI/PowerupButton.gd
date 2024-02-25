extends Button

@export var PowerupContent : LevelPowerUpResource

func _ready():
	return
	if is_instance_valid(PowerupContent):
		$VBoxContainer/Label.text = PowerupContent.GetDescription()

func GivePowerup():
	if is_instance_valid(PowerupContent):
		PowerupContent.ConsumePower()
	PlayerProgression.BroadcastPowerUpSelected()

func _on_button_down():
	GivePowerup()
