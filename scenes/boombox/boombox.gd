extends Sprite2D

var timer = 0

func _process(delta: float) -> void:
	timer+=delta
	sway()

func sway():
	rotation = cos(timer*.7)*0.3/PI + 0.2

func _input(event: InputEvent) -> void:
	if event.as_text() == "Space" and event.is_pressed():
		bounce()

func bounce():
	print("bounce")
	var tween1 = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	
	tween2.tween_property($speaker_2, "scale", Vector2(1.5,1.5), 0.1).set_trans(Tween.TRANS_BOUNCE)
	tween1.tween_property($speaker_1, "scale", Vector2(1.5,1.5), 0.1).set_trans(Tween.TRANS_BOUNCE)
	
	tween2.tween_property($speaker_2, "scale", Vector2(1,1), 2.2).set_trans(Tween.TRANS_BOUNCE)
	tween1.tween_property($speaker_1, "scale", Vector2(1,1), 2.2).set_trans(Tween.TRANS_BOUNCE)
