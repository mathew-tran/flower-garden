extends Sprite2D


func _ready():
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", Vector2(-100, 475), 15)
	await tween.finished
	queue_free()
