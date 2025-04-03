extends Node2D
var time = 0.0
var money : int = 0:
	set(value):
		money = value
		$Bill/Label.text = money
	
func _process(delta: float) -> void:
	
	sway(delta)

func sway(delta):
	$Bill.position.y = sin(time)*6.0
	time+=delta
	pass
