extends Resource
class_name ProgressionProperty

func Get():
	var name = resource_path.get_file().trim_suffix(".tres")
	return name
