extends AnimatedSprite2D


var bIsHovered = false

var progress = 0.0

func _ready():
	$Flower.connect("UpdateGrowth", Callable(self, "OnUpdateGrowth"))
	$Flower.connect("FinishGrowth", Callable(self, "OnFinishGrowth"))

func OnUpdateGrowth(type):
	$ActionHint.SetHint(type)

func OnFinishGrowth():
	$ActionHint.HideHint()

func _on_area_2d_mouse_entered():
	InputManager.SetFocusedObject(self)


func _on_area_2d_mouse_exited():
	InputManager.SetFocusedObject(null)

func Click():
	print(name + " has been clicked")
	GetPlant().AttemptGrow()

func GetPlant():
	return $Flower

func _physics_process(delta):
	progress += delta
	if progress >= .000001:
		progress = 0
		UpdateUI()

func UpdateUI():
	$TextureProgressBar.visible = false
	if is_instance_valid(GetPlant()):
		if GetPlant().IsCompleted() == false:
			$TextureProgressBar.visible = true
			$TextureProgressBar.value = GetPlant().GetCurrentStage().GetTimeLeft()
			$TextureProgressBar.max_value = GetPlant().GetCurrentStage().GetMaxTime()

