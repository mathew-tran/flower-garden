extends Panel

@onready var PlantButtonClass = preload("res://Prefabs/UI/Screens/PlantBook/PlantBookButton.tscn")
@onready var PlantContainer = $Panel/Panel/ScrollContainer/VBoxContainer

var bIsSetup = false

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
		
	bIsSetup = true
	
func OnPlantDataSelected(plantData : PlantData):
	$LeftSide.ShowPlantData(plantData)
	$AudioStreamPlayer2D.play()
	


func _on_plant_book_button_button_up():
	visible = true

func _on_close_button_button_up():
	visible = false
	
func _input(event):
	if event.is_action_pressed("escape"):
		if visible:
			visible = false

func _on_visibility_changed():
	if is_visible_in_tree():
		if visible:
			for child in PlantContainer.get_children():
				child.Update()
			InputManager.ShowMouse.emit(false)
	else:
		InputManager.ShowMouse.emit(true)
