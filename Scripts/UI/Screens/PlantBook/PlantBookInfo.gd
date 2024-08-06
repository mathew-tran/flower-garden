extends Panel

@onready var FlowerImage = $FlowerImage
@onready var FlowerTitle = $Panel/FlowerTitle
@onready var FlowerDescription = $Panel2/FlowerDescription

func ShowPlantData(plantData : PlantData):
	FlowerImage.texture = plantData.PlantPicture
	FlowerTitle.text = plantData.FlowerName.to_upper()
	FlowerDescription.text = plantData.FlowerDescription
