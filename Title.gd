extends Node2D
var time = 0.0

func _process(delta):
	sway(delta)
	
func sway(delta):
	var posValue = sin(time)*6.0
	var rotValue = cos(time*.3)*1.0/(8.0*PI)
	$Center/Bar1.position.x = posValue
	$Center/Bar1.rotation = rotValue
	$Center/Bar2.position.x = -sin(time*.7)*6.0
	$Center/Bar2.rotation = -cos(time*.5)*1.0/(6.0*PI)
	$Center/Bar3.position.x = sin(time*.9)*8.0
	$Center/Bar3.rotation = -cos(time*.5)*1.0/(8.0*PI)
	
	time+=delta
	pass
