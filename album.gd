extends Node2D
@export var owned : bool = false
@export var albumNumber : int = 0

var time = 0.0
var tween : Tween
#var tooltipTween : Tween
func _ready() -> void:
	$Tooltip.hide()
	appear()
	
func _process(delta: float) -> void:
	sway(delta)
	if(owned):
		$Tooltip/TooltipBox/PriceTag.hide()
		$Tooltip/Price.hide()
	pass

func appear():
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	self.scale = Vector2(0.5,0.5)
	tween.tween_property(self,"scale",Vector2(1.0,1.0),1.0)

func pop():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	$Album.scale = Vector2(1.,1.)
	tween.parallel().tween_property($Album,"scale",Vector2(1.2,1.2),1.0)
	$Tooltip.show()
	$Tooltip.scale = Vector2(0.5,0.5)
	tween.parallel().tween_property($Tooltip,"position.x",48.0,1.0)
	tween.parallel().tween_property($Tooltip,"scale",Vector2(1.0,1.0),1.0)
		
func shrink():
	tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property($Album,"scale",Vector2(1.0,1.0),1.0)
	tween.parallel().tween_property($Tooltip,"scale",Vector2(0.3,0.3),1.0)
	tween.tween_callback($Tooltip.hide).set_delay(.1)

func sway(delta):
	$Album.position.y = sin(time)*6.0
	$Album.rotation = cos(time*.3)*1.0/PI
	$Tooltip.position.y = sin(time*1.5)*3.0
	time+=delta
	pass

func click():
	tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	$Album.scale = Vector2(1.0,1.0)
	tween.tween_property($Album,"scale",Vector2(1.4,1.4),1.0)
	print("click")
	

func _on_enter_area_mouse_entered() -> void:
	pop()
	pass # Replace with function body.


func _on_exit_area_mouse_exited() -> void:
	shrink()
	pass # Replace with function body.


func _on_enter_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	click()
	if(!owned):
		print("Buying album")
		owned = true
	pass # Replace with function body.
