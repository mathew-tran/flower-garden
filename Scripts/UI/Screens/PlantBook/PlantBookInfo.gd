extends Panel

@onready var FlowerImage = $FlowerImage
@onready var FlowerTitle = $Panel/FlowerTitle
@onready var FlowerDescription = $Panel2/FlowerDescription

func ShowPlantData(plantData : PlantData):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1,0), .2)
	await tween.finished
	FlowerImage.texture = plantData.PlantPicture
	FlowerTitle.text = plantData.FlowerName.to_upper()
	FlowerDescription.text = plantData.FlowerDescription
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "scale", Vector2.ONE, .2)
