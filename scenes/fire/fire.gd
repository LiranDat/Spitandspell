extends TextureRect

var timer = 1

func _process(delta: float) -> void:
	timer -= delta
	self.modulate.a = timer
	if timer < 0:
		self.queue_free()
