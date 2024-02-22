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

func AddFlower(flowerObj):
	flowerObj.reparent(self)
	flowerObj.show_behind_parent = true
	flowerObj.position = Positions.pop_back()
