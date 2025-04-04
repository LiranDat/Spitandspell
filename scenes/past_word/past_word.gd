extends RichTextLabel

var timer = 0
var random

func _ready() -> void:
	randomize()
	random = randf()

func _process(delta: float) -> void:
	timer += delta
	self.position.y -= 30 * delta
	self.modulate.a -= 0.3 * delta
	
	self.rotation_degrees = sin((random-0.5) * 4 * (timer / 3)) * 7
	
	if timer > 5:
		self.queue_free()
