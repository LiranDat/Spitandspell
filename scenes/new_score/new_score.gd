extends RichTextLabel

var amount = 0
var timer = 0
var random

func _ready() -> void:
	randomize()
	random = randf()
	
	self.position.x = 10
	self.position.y = 10
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	self.scale = Vector2(0.5,0.5)
	tween.tween_property(self,"scale",Vector2(2.0,2.0),1.0)

func _process(delta: float) -> void:
	timer += delta
	self.position.y -= 30 * delta
	self.modulate.a -= 1.5 * delta
	
	self.rotation_degrees = sin((random-0.5) * 4 * (timer / 3)) * 7
	
	if timer > 1:
		self.queue_free()
