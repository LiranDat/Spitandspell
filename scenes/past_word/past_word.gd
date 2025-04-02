extends RichTextLabel

var timer = 0

func _process(delta: float) -> void:
	timer += delta
	self.position.y -= 30 * delta
	self.modulate.a -= 0.3 * delta
	
	self.rotation_degrees = sin(timer) * 3
	
	if timer > 5:
		self.queue_free()
