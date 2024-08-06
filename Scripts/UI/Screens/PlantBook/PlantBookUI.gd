extends Panel

@onready var PlantButtonClass = preload("res://Prefabs/UI/Screens/PlantBook/PlantBookButton.tscn")
@onready var PlantContainer = $Panel/Panel/ScrollContainer/VBoxContainer
func _ready():
	PopulatePlantData()
	
func PopulatePlantData():
	for child in PlantContainer.get_children():
		child.queue_free()
		
	await get_tree().process_frame
	
	var plants = Helper.GetAllFilePaths("res://Resources/Plants")
	for plant in plants:
		var instance = PlantButtonClass.instantiate()
		instance.Setup(load(plant))
		PlantContainer.add_child(instance)
		instance.PlantDataSelected.connect(OnPlantDataSelected)
		
func OnPlantDataSelected(plantData : PlantData):
	$LeftSide.ShowPlantData(plantData)
	


func _on_plant_book_button_button_up():
	visible = true


func _on_close_button_button_up():
	visible = false

func _input(event):
	if event.is_action_pressed("escape"):
		if visible:
			visible = false
