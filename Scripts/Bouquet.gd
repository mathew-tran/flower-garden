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

func OnCompleteRound():
	ClearFlowers()
	Positions.shuffle()

func AddFlower(flowerObj):
	flowerObj.reparent(self)
	flowerObj.show_behind_parent = true
	flowerObj.position = Positions.pop_back()

func ClearFlowers():
	await get_tree().create_timer(1).timeout
	for child in get_children():
		Positions.push_back(child.position)
		child.queue_free()
