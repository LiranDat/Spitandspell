extends Node2D

var time = 0.0
var tween : Tween
var letterListScene = preload("res://letter_list.tscn")

func _process(delta: float) -> void:
	sway(delta)
	pass
	
func sway(delta):
	$Sprite2D.position.y = sin(time)*6.0
	$Sprite2D.rotation = sin(time*.6)*PI/8.0+PI/4.0
	time+=delta
	pass
	
func pop():
	if(tween):
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	$Sprite2D.scale = Vector2(.4,.9)
	tween.tween_property($Sprite2D,"scale",Vector2(1.0,1.0),1.0)
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_tree().root.get_child(0).add_child(letterListScene.instantiate())
	pass # Replace with function body.
