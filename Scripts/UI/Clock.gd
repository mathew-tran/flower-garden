extends Panel


func _ready():
	_on_timer_timeout()
	
func _on_timer_timeout():
	$Label.text = GetRealTime()


func GetRealTime():
	var current_time = Time.get_datetime_dict_from_system()
	var hour = current_time.hour
	var minute = current_time.minute
	var am_pm = "AM"

	if hour >= 12:
		am_pm = "PM"
	if hour > 12:
		hour -= 12
	elif hour == 0:
		hour = 12

	var time_string = str(hour).pad_zeros(2) + ":" + str(minute).pad_zeros(2) + am_pm
	return time_string
