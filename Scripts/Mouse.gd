extends Sprite2D

func _ready():
	InputManager.connect("ModeChange", Callable(self, "OnModeChange"))
	OnModeChange(InputManager.CurrentInputMode)

func OnModeChange(type):
	if type == InputManager.INPUT_MODE.WATER:
		texture = load("res://Art/UI/WaterIcon.png")
	elif type == InputManager.INPUT_MODE.TEND:
		texture = load("res://Art/UI/TendIcon.png")
	elif type == InputManager.INPUT_MODE.MOVE:
		texture = load("res://Art/UI/MoveIcon.png")
func _process(delta):
	global_position = get_global_mouse_position()

