extends AudioStreamPlayer

func count():
	self.play()
	await get_tree().create_timer(0.6).timeout
	self.pitch_scale = 0.9
	self.play()
	await get_tree().create_timer(0.6).timeout
	self.play()
	await get_tree().create_timer(0.6).timeout
	self.play()
	await get_tree().create_timer(0.6).timeout
