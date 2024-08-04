extends Sprite2D

var Positions = [
	Vector2(-9, -20.5),
	Vector2(0, -19.5),
	Vector2(10, -22),
	Vector2(-4, -29.5),
	Vector2(5.5, -29.5),
	Vector2(0, -13)
]

func _ready():
	add_to_group("Bouquet")
	Positions.shuffle()
	Game.connect("CompleteRound", Callable(self, "OnCompleteRound"))

func OnCompleteRound(_x):
	ClearFlowers()
	Positions.shuffle()

func AddFlower(flowerObj):
	flowerObj.reparent(self)
	flowerObj.show_behind_parent = true
	var tween = get_tree().create_tween()
	tween.tween_property(flowerObj, "position", Positions.pop_back(), .5)
	
	var originalScale = flowerObj.scale
	flowerObj.scale *= 3
	tween.tween_property(flowerObj, "scale", originalScale, .5)
	await tween.finished
	$AnimationPlayer.play("animate")

func ClearFlowers():
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(2).timeout
	for child in get_children():
		if child is AnimationPlayer:
			continue
		if child is AudioStreamPlayer2D:
			continue
		else:
			Positions.push_back(child.position)
			child.queue_free()
