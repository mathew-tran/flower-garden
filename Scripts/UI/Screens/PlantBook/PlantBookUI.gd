extends Panel

@onready var PlantButtonClass = preload("res://Prefabs/UI/Screens/PlantBook/PlantBookButton.tscn")
@onready var PlantContainer = $Panel/Panel/ScrollContainer/VBoxContainer
@onready var ScrollingContainer = $Panel/Panel/ScrollContainer

var bIsSetup = false
var bIsAnimating = false

func _ready():
	PopulatePlantData()
	position = Vector2(-2000,0)
	ScrollingContainer.get_v_scroll_bar().size.x = 100
	
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
	if bIsAnimating:
		return
		
	visible = true

func _on_close_button_button_up():
	Close()
	
func Close():
	if bIsAnimating:
		return
	bIsAnimating = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(-2000,0), .5)
	await tween.finished
	visible = false
	bIsAnimating = false
	
	
func _input(event):
	if event.is_action_pressed("escape"):
		if visible:
			Close()

func _process(delta):
	print(position)
	
func _on_visibility_changed():
	if is_visible_in_tree():
		if visible:
			for child in PlantContainer.get_children():
				child.Update()
			InputManager.ShowMouse.emit(false)
			bIsAnimating = true
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", Vector2.ZERO, .5)
			tween.set_trans(Tween.TRANS_EXPO)
			await tween.finished
			bIsAnimating = false
	else:
		InputManager.ShowMouse.emit(true)
