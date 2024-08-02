extends Sprite2D

var UseTween = null

func _ready():
	InputManager.connect("ModeChange", Callable(self, "OnModeChange"))
	OnModeChange(InputManager.CurrentInputMode)

func OnModeChange(type):
	texture = Definitions.GetIcon(type)
		
func _process(delta):
	global_position = get_global_mouse_position() - Vector2(1,1) * 86
		
	if Input.is_action_just_pressed("mouse_left_click"):
		if is_instance_valid(UseTween):
			UseTween.stop()
		UseTween = get_tree().create_tween()
		UseTween.tween_property(self, "rotation_degrees", 20, .1)
		await UseTween.finished
		UseTween = get_tree().create_tween()
		UseTween.tween_property(self, "rotation_degrees", 0, .1)
		UseTween.set_trans(Tween.TRANS_QUAD)
		await UseTween.finished
		UseTween = null
