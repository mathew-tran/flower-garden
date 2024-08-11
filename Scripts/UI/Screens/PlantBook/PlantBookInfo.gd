extends Panel

@onready var FlowerImage = $FlowerImage
@onready var FlowerTitle = $Panel/FlowerTitle
@onready var FlowerDescription = $Panel2/FlowerDescription

func _ready():
	FlowerImage.texture = preload("res://Art/MagnifyingGlass.svg")
	FlowerTitle.text = ""
	FlowerDescription.text = "Select a plant to know more about it!"
func ShowPlantData(plantData : PlantData):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1,0), .1)
	await tween.finished
	if plantData.IsUnlocked():
		FlowerImage.texture = plantData.PlantPicture
		FlowerTitle.text = plantData.FlowerName.to_upper()
		FlowerDescription.text = plantData.FlowerDescription
	else:
		FlowerImage.texture = null
		FlowerTitle.text = "???"
		FlowerDescription.text = "???"
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "scale", Vector2.ONE, .1)
