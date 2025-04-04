extends Node2D
var time = 0.0

func _process(delta):
	sway(delta)
	
func sway(delta):
	var posValue = sin(time)*6.0
	var rotValue = cos(time*.3)*1.0/(8.0*PI)
	$Bar1.position.x = posValue
	$Bar1.rotation = rotValue
	$Bar2.position.x = -sin(time*.7)*6.0
	$Bar2.rotation = -cos(time*.5)*1.0/(6.0*PI)
	$Bar3.position.x = sin(time*.9)*8.0
	$Bar3.rotation = -cos(time*.5)*1.0/(8.0*PI)
	
	time+=delta
	pass
