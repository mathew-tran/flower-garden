extends Resource
class_name LevelPowerUpResource

@export var PowerUpDescription = "Description"
@export var Powerup : LevelPowerUpPropertyResource

func GetDescription():
	return PowerUpDescription

func ConsumePower():
	Powerup.Consume()
