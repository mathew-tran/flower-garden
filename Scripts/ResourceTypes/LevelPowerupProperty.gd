extends Resource
class_name LevelPowerUpPropertyResource

func Get():
	var name = resource_path.get_file().trim_suffix(".tres")
	return name
