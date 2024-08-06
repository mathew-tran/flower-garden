extends Sprite2D

var UseTween = null

var CurrentType : InputManager.INPUT_MODE
func _ready():
	InputManager.connect("ModeChange", Callable(self, "OnModeChange"))
	OnModeChange(InputManager.CurrentInputMode)
	InputManager.ShowMouse.connect(OnShowMouse)

func OnShowMouse(bShow):
	visible = bShow
	
func OnModeChange(type):
	texture = Definitions.GetIcon(type)
	CurrentType = type
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, .05)
	await tween.finished
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(2,2), .1)
	await tween.finished
		
func _process(_delta):
	
	if CurrentType != InputManager.INPUT_MODE.MOVE:
		global_position = get_global_mouse_position() - Vector2(1,1) * 86
	else:
		global_position = get_global_mouse_position() - Vector2(1,1) * 52
	
		
	if Input.is_action_just_pressed("mouse_left_click"):
		if visible == false:
			return
		if is_instance_valid(UseTween):
			UseTween.stop()
		if CurrentType == InputManager.INPUT_MODE.MOVE:
			$SFX.stream = load("res://Audio/SFX/Mouth_33.mp3")
		if CurrentType == InputManager.INPUT_MODE.WATER:
			$SFX.stream = load("res://Audio/SFX/Mouth_05.mp3")
		if CurrentType == InputManager.INPUT_MODE.TEND:
			$SFX.stream = load("res://Audio/SFX/Mouth_37.mp3")
		
		$SFX.pitch_scale = randf_range(.8, 1.1)
		$SFX.play()
		UseTween = get_tree().create_tween()
		UseTween.tween_property(self, "rotation_degrees", 20, .1)
		await UseTween.finished
		UseTween = get_tree().create_tween()
		UseTween.tween_property(self, "rotation_degrees", 0, .1)
		UseTween.set_trans(Tween.TRANS_QUAD)
		await UseTween.finished
		UseTween = null
		
