extends AnimatedSprite2D


var bIsHovered = false

var progress = 0.0

var Flower = null

var PushUpTween = null
var PushDownTween = null

var StartPosition

signal FlowerBoxComplete

func SetPlant(path):
	Flower = load(path).instantiate()
	add_child(Flower)
	Flower.connect("UpdateGrowth", Callable(self, "OnUpdateGrowth"))
	Flower.connect("FinishGrowth", Callable(self, "OnFinishGrowth"))
	Flower.connect("Completed", Callable(self, "OnCompleted"))

func _ready():
	StartPosition = global_position
	add_to_group("PlanterBox")
	connect("FlowerBoxComplete", Callable(self, "CheckBoxesComplete"))
	OnFinishGrowth()

func CheckBoxesComplete():
	if Game.ArePlanterBoxesCompleted():
		Game.SetNewRound()

func OnUpdateGrowth(type):
	$ActionHint.SetHint(type)
	PushUpTween = get_tree().create_tween()
	PushUpTween.tween_property(self, "position", StartPosition + Vector2(0, 10), .4)
	PushUpTween.tween_property(self, "modulate", Color.WHITE, .4)
	PushUpTween.play()

func OnFinishGrowth():
	$ActionHint.HideHint()
	PushDownTween = get_tree().create_tween()
	PushDownTween.tween_property(self, "position", StartPosition, .4)
	PushDownTween.tween_property(self, "modulate", Color.SILVER, .4)
	PushDownTween.play()

func OnCompleted():
	var bouquet = get_tree().get_nodes_in_group("Bouquet")
	if bouquet:
		bouquet[0].AddFlower(Flower)
		Flower = null
	OnFinishGrowth()
	emit_signal("FlowerBoxComplete")

func _on_area_2d_mouse_entered():
	InputManager.SetFocusedObject(self)
	self_modulate = Color.SILVER


func _on_area_2d_mouse_exited():
	InputManager.SetFocusedObject(null)
	self_modulate = Color.WHITE

func Click():
	print(name + " has been clicked")
	if is_instance_valid(GetPlant()):
		GetPlant().AttemptGrow()

func GetPlant():
	return Flower

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

