extends Node2D

var time = 0.0

func _process(delta: float) -> void:
	sway(delta)
	pass
	
func sway(delta):
	$Sprite2D.position.y = sin(time)*6.0
	$Sprite2D.rotation = sin(time*.6)*PI/8.0+PI/4.0
	time+=delta
	pass
	
func pop():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	self.scale = Vector2(.6,1.0)
	tween.parallel().tween_property(self,"scale",Vector2(1.0,1.0),1.0)
	pass
