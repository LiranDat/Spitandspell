extends Button

func _ready() -> void:
	self.pressed.connect(_button_pressed)

func _button_pressed():
	get_tree().reload_current_scene()
