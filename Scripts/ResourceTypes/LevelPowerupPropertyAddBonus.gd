extends LevelPowerUpPropertyResource
class_name LevelPowerUpPropertyAddBonusResource

@export var PropertyName : ProgressionProperty
@export var PropertyValue = 0

func Consume():
	PlayerProgression.AddTempPower(PropertyName.Get(), PropertyValue)
