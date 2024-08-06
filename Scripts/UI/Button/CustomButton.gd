extends Button

class_name CustomButton

var OriginalScale : Vector2

func _ready():
	mouse_entered.connect(OnMouseHovered)
	mouse_exited.connect(OnMouseExited)
	
func _enter_tree():
	OriginalScale = scale
	
func OnMouseHovered():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.SILVER, .1)
	tween.tween_property(self, "scale", OriginalScale + Vector2(.01,.01), .1)
	
func OnMouseExited():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, .1)
	tween.tween_property(self, "scale", OriginalScale, .1)
