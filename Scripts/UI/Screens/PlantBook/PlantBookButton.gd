extends Button

class_name PlantBookButton

@export var Data : PlantData

signal PlantDataSelected(data)

func Setup(newData):
	Data = newData
	
func _ready():
	Update()

func Update():
	if is_instance_valid(Data):
		if Progression.GetKeyValue(Data.GetUnlockID()):
			text = Data.FlowerName.to_upper()
			if Data.HasBeenViewed() == false:
				$TextureRect.visible = true
			else:
				$TextureRect.visible = false
				
		else:
			text = "???"
		
func _on_button_up():
	PlantDataSelected.emit(Data)
	if Progression.GetKeyValue(Data.GetUnlockID()):
		Data.SetHasBeenViewed()
		Update()
		
		
