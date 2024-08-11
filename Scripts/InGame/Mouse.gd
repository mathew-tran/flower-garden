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
		
func IsSwitchButtonPressed():
	return Input.is_action_just_pressed("f1") or Input.is_action_just_pressed("f2") or Input.is_action_just_pressed("f3")

func _process(_delta):
	
	if CurrentType != InputManager.INPUT_MODE.MOVE:
		global_position = get_global_mouse_position() - Vector2(1,1) * 86
	else:
		global_position = get_global_mouse_position() - Vector2(1,1) * 52
	
	if IsSwitchButtonPressed():
		
		var event_lmb = InputEventMouseButton.new()
		event_lmb.pressed = true
		event_lmb.button_index = MOUSE_BUTTON_LEFT
		event_lmb.position = get_global_mouse_position()
		Input.parse_input_event(event_lmb)
		await get_tree().process_frame
		await get_tree().process_frame
		event_lmb.pressed = false
		Input.parse_input_event(event_lmb)
		var boxes = get_tree().get_nodes_in_group("PlanterBox")
		var chosenBox = boxes[0]
		for box in boxes:
			if box.global_position.distance_to(get_global_mouse_position()) < chosenBox.global_position.distance_to(get_global_mouse_position()):
				chosenBox = box
		
		if chosenBox.global_position.distance_to(get_global_mouse_position()) < 100:
			chosenBox.Click()
			
	if Input.is_action_just_pressed("mouse_left_click") or IsSwitchButtonPressed():
		
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
		
