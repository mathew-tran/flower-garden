extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	while true:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", Vector2(-100, 475), 15)
		await tween.finished
		global_position = Vector2(2225, 475)
		var timer = get_tree().create_timer(randf_range(1, 10))
		await timer.timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
