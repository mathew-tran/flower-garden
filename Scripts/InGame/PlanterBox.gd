extends Sprite2D


var bIsHovered = false

var progress = 0.0

var Flower = null

var PushUpTween = null
var PushDownTween = null

var StartPosition

signal FlowerBoxComplete

var Data : PlantData

func SetPlant(plantData : PlantData):
	Data = plantData
	Flower = plantData.GetPlantScene().instantiate()
	add_child(Flower)
	Flower.show_behind_parent = true
	Flower.connect("UpdateGrowth", Callable(self, "OnUpdateGrowth"))
	Flower.connect("FinishGrowth", Callable(self, "OnFinishGrowth"))
	Flower.connect("Completed", Callable(self, "OnCompleted"))
	OnFinishGrowth()

func _enter_tree():
	$ActionHint.HideHint()

func _ready():
	StartPosition = global_position
	add_to_group("PlanterBox")
	connect("FlowerBoxComplete", Callable(self, "CheckBoxesComplete"))

func CheckBoxesComplete():
	if Game.ArePlanterBoxesCompleted():
		Game.SetNewRound()

func OnUpdateGrowth(type):
	$ActionHint.SetHint(type)
	AnimateFlowerUp()
	$AudioStreamPlayer2D.pitch_scale = randf_range(.8, 1.1)
	$AudioStreamPlayer2D.play()

func AnimateFlowerUp():
	PushUpTween = get_tree().create_tween()
	PushUpTween.tween_property(self, "position", StartPosition , .4)
	PushUpTween.tween_property(self, "modulate", Color.WHITE, .4)
	PushUpTween.play()
	
func AnimateFlowerDown():
	PushDownTween = get_tree().create_tween()
	PushDownTween.tween_property(self, "position", StartPosition + Vector2(0, 10), .4)
	PushDownTween.tween_property(self, "modulate", Color.SILVER, .4)
	PushDownTween.play()
			
func OnFinishGrowth():
	$ActionHint.HideHint()
	AnimateFlowerDown()

func OnCompleted():
	var bouquet = get_tree().get_nodes_in_group("Bouquet")
	Data.Unlock()
	$CPUParticles2D.emitting = true
	if bouquet:
		bouquet[0].AddFlower(Flower)
		Flower = null
	
	emit_signal("FlowerBoxComplete")
	AnimateFlowerUp()
	Game.GiveXP.emit(10 + randi_range(2, 4))
	
func Click():
	if is_instance_valid(GetPlant()):
		GetPlant().AttemptGrow()
	_on_button_focus_entered()
		
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

func _on_button_button_up():
	Click()


func _on_button_focus_entered():
	InputManager.SetFocusedObject(self)
	self_modulate = Color.SILVER
	$Timer.start()

func _on_button_focus_exited():
	InputManager.SetFocusedObject(null)
	self_modulate = Color.WHITE
	$Button.release_focus()

func _on_timer_timeout():
	_on_button_focus_exited()
