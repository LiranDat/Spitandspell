extends Node2D
var time = 0.0
var money : int = Globals.STARTINGMONEY:
	set(value):
		money = value
		$Bill/Label.text = str(money)
	
func _process(delta: float) -> void:
	
	sway(delta)

func sway(delta):
	$Bill.position.y = sin(time)*6.0
	time+=delta
	pass
