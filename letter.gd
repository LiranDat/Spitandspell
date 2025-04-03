extends Node2D
var time = 0.0
var spawn = true
@export var letter : String = "A"
@export var score : int = 1

var swayEnabled = true

func _ready():
	$Letter/Text.text = letter
	$Letter/Score.text = str(score)
	appear()

func _process(delta: float) -> void:
	if(swayEnabled):
		sway(delta)
	pass

func appear():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	$Letter.scale = Vector2(0.5,0.5)
	tween.tween_property($Letter,"scale",Vector2(1.0,1.0),1.0)
	pass
	
func shake():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	$Letter.scale = Vector2(0.2,0.8)
	tween.tween_property($Letter,"scale",Vector2(1.0,1.0),1.0)
	pass
	
func sway(delta):
	$Letter.position.y = sin(time)*6.0
	rotation = cos(time*.3)*1.0/PI
	time+=delta
	pass
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shake()
	pass # Replace with function body.
