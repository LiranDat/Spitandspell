extends RichTextLabel

var timer = 0

func sway():
	rotation = cos(timer*.7)*0.08/PI

func _process(delta):
	timer += delta
	sway()
