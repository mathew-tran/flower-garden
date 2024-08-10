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
	if IsUnlocked():
		return
	Progression.UpdateKey(GetUnlockID(), {
		"viewed" : false
	})
	Game.NewFlowerFound.emit()
	Game.GiveXP.emit(50)

func HasBeenViewed():
	var data = Progression.GetKeyValue(GetUnlockID())
	if data == null:
		return false
	else:
		return data["viewed"]
		
func SetHasBeenViewed():
	Progression.UpdateKey(GetUnlockID(), {
		"viewed" : true
	})
