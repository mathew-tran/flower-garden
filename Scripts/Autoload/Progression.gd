extends Node

var Data = {}

var SaveFilePath = "user://savegame.save"

func _ready():
	Load()
	
func Load():
	if FileAccess.file_exists(SaveFilePath):
		var file = FileAccess.open(SaveFilePath, FileAccess.READ)
		Data = file.get_var()
		print("Data loaded")
		print(Data)
		file.close()
	else:
		Data = {}
		print("No Data found")

func Save():
	var file = FileAccess.open(SaveFilePath,FileAccess.WRITE)
	file.store_var(Data)
	file.close()
	
func ClearData():
	Data = {}
	Save()
	
func UpdateKey(key, value):
	Data[key] = value
	Save()
	
func GetKeyValue(key):
	if Data.has(key):
		return Data[key]
	return null
