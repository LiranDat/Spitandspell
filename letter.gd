extends Sprite2D
var time = 0.0
var spawn = true
@export var letter : String = "A"
@export var score : int = 1

func _ready():
	$Text.text = letter
	$Score.text = str(score)
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	self.scale = Vector2(0.5,0.5)
	tween.tween_property(self,"scale",Vector2(1.0,1.0),1.0)
	

func _process(delta: float) -> void:
	position.y = sin(time)*6.0
	rotation = cos(time*.3)*1.0/PI
	time+=delta
	pass
