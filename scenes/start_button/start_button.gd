extends Button

var timer = 0

func _ready() -> void:
	self.pressed.connect(_button_pressed)

func _process(delta: float) -> void:
	timer += delta

func sway(delta):
	self.position.y = sin(timer)*6.0
	rotation = cos(timer*.3)*1.0/PI
	timer+=delta

func _button_pressed():
	get_parent().start_lyrics()
	self.queue_free()
