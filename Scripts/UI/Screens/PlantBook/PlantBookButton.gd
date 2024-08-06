extends Button

@export var Data : PlantData

signal PlantDataSelected(data)

func Setup(newData):
	Data = newData
	
func _ready():
	if is_instance_valid(Data):
		text = Data.FlowerName


func _on_button_up():
	PlantDataSelected.emit(Data)
