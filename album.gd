extends Sprite2D
var time = 0.0
var positionBase = 0.0
var positionOffset = 0.0

func _ready() -> void:
	positionBase = self.position.y
	$Tooltip.hide()
	appear()
	
func _process(delta: float) -> void:
	sway(delta)
	position.y = positionBase+positionOffset
	pass

func appear():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	self.scale = Vector2(0.5,0.5)
	tween.tween_property(self,"scale",Vector2(1.0,1.0),1.0)

func pop():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	self.scale = Vector2(1.0,1.0)
	tween.tween_property(self,"scale",Vector2(1.2,1.2),1.0)
	$Tooltip.show()
	var tooltipTween = get_tree().create_tween()
	tooltipTween.set_ease(Tween.EASE_OUT)
	tooltipTween.set_trans(Tween.TRANS_ELASTIC)
	$Tooltip.scale = Vector2(0.3,0.3)
	tween.tween_property(self,"scale",Vector2(1.2,1.2),1.0)

func shrink():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self,"scale",Vector2(1.0,1.0),1.0)

func sway(delta):
	positionOffset = sin(time)*6.0
	rotation = cos(time*.3)*1.0/PI
	time+=delta
	pass
	


func _on_area_2d_mouse_entered() -> void:
	pop()
	pass # Replace with function body.


func _on_exit_area_mouse_exited() -> void:
	shrink()
	pass # Replace with function body.
