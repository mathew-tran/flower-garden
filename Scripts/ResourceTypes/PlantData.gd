extends Resource

class_name PlantData

@export var PlantScene : PackedScene
@export var PlantPicture : Texture2D
@export var FlowerName : String
@export_multiline var FlowerDescription

func GetPlantScene():
	return PlantScene
