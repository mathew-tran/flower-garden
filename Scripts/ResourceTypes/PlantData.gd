extends Resource

class_name PlantData

@export var PlantScene : PackedScene
@export var PlantPicture : Texture2D
@export var FlowerName : String
@export_multiline var FlowerDescription
@export var UnlockID = "001"

func GetPlantScene():
	return PlantScene

func IsUnlocked():
	var value = Progression.GetKeyValue(GetUnlockID())
	return value != null

func GetUnlockID():
	return "FLOWER" + UnlockID

func Unlock():
	Progression.UpdateKey(GetUnlockID(), true)
