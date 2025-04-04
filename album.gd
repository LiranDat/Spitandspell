class_name Album extends Node2D
var owned : bool = false

var albumNumber : int = 0:
	set(value):
		albumNumber = value
		updateAlbumInfo()

var price : int = 0

const ALBUMFILE = "res://albums.xml"
const ALBUMATTRIBUTES = ["id","title","description","subdescript","price"]
const vowels = ["A","E","I","O","U"]
var time = 0.0
var tween : Tween
var hovering : bool = false
var currentState : bool = false
#var tooltipTween : Tween
	
func _ready() -> void:
	$Tooltip.hide()
	appear()
	updateAlbumInfo()
	pass
	
func _process(delta: float) -> void:
	sway(delta)
	if(owned):
		$Tooltip/PriceTag.hide()
		$Tooltip/Price.hide()
	pass

func scoreLetter(letter:String, word:String):
	if(albumNumber==0):
		return scoreLetter0(letter,word)
	else:
		return [0,1]
	pass

func scoreWord(word:String):
	if(albumNumber==0):
		return scoreWord0(word)
	return [0,1]
	pass

func updateAlbumInfo():
	var albumInfo = {}
	albumInfo = parseAlbums()[albumNumber]
	print(albumInfo)
	$Album.frame=albumNumber
	$Album/Shadow.frame=albumNumber
	#["id","title","description","subdescr","price"]
	var albumName :String = albumInfo["title"]
	$Tooltip/AlbumName.text = albumName
	var textSize = max($Tooltip/AlbumName.size.x,$Tooltip/AlbumDescription.size.x,$Tooltip/AlbumDescription/AlbumSubDescription.size.x)
	if(textSize>90.0):
		$Tooltip/TooltipBox.scale.x = (textSize+10.0)*1.1
	$Tooltip/AlbumDescription.text = albumInfo["description"]
	$Tooltip/AlbumDescription/AlbumSubDescription.text = albumInfo["subdescript"]
	$Tooltip/Price.text = albumInfo["price"]+ " $"
	self.price=albumInfo["price"]
	pass

func appear():
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	self.scale = Vector2(0.5,0.5)
	tween.tween_property(self,"scale",Vector2(1.0,1.0),1.0)
	await tween.finished
	pass

func pop():
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	$Album.scale = Vector2(1.,1.)
	tween.parallel().tween_property($Album,"scale",Vector2(1.2,1.2),1.0)
	$Tooltip.show()
	$Tooltip.scale = Vector2(0.5,0.5)
	tween.parallel().tween_property($Tooltip,"position:x",48.0,1.0)
	tween.parallel().tween_property($Tooltip,"scale",Vector2(1.0,1.0),1.0)
	pass
		
func shrink():
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property($Album,"scale",Vector2(1.0,1.0),1.0)
	tween.parallel().tween_property($Tooltip,"scale",Vector2(0.3,0.3),1.0)
	tween.parallel().tween_property($Tooltip,"position:x",0.0,1.0)
	tween.tween_callback($Tooltip.hide).set_delay(.1)
	pass

func sway(delta):
	$Album.position.y = sin(time)*6.0
	$Album.rotation = cos(time*.3)*1.0/PI
	$Tooltip.position.y = sin(time*1.5)*3.0
	time+=delta
	pass

func click():
	if(tween):
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_parallel(false)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property($Album,"scale",Vector2(1.3,1.3),.25)
	tween.tween_property($Album,"scale",Vector2(1.2,1.2),.25)
	pass

func start_tween() -> void:
	if tween:
		tween.kill()
	
	tween = create_tween()

func _on_enter_area_mouse_entered() -> void:
	$EnterArea.input_pickable = false
	$ExitArea.input_pickable = false
	await get_tree().create_timer(0.1)
	start_tween()
	pop()
	await get_tree().create_timer(0.1)
	$EnterArea.input_pickable = true
	$ExitArea.input_pickable = true
	pass # Replace with function body.


func _on_exit_area_mouse_exited() -> void:
	$EnterArea.input_pickable = false
	$ExitArea.input_pickable = false
	await get_tree().create_timer(0.1)
	start_tween()
	shrink()
	await get_tree().create_timer(0.1)
	$EnterArea.input_pickable = true
	$ExitArea.input_pickable = true
	pass # Replace with function body.

func _on_enter_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click()
			if(!owned):
				var case = get_tree().get_first_node_in_group("AlbumCase")
				if(case):
					if(!case.isFull()):
						if(case.buyAlbum(self)):
							owned = true
	pass # Replace with function body.


func _on_enter_area_mouse_exited():
	pass # Replace with function body.

func parseAlbums():
	var doc : XMLDocument
	var albums = []
	doc = XML.parse_file(ALBUMFILE)
	for node in doc.root.children:
		var album = {}
		for part in node.children:
			for attribute in ALBUMATTRIBUTES:
				if(part.to_dict()["__name__"]==attribute):
					album[attribute] = part.content
		for attribute in ALBUMATTRIBUTES:
			if(!album.has(attribute)):
				album[attribute]=""
		albums.append(album)
	return albums
	pass

func scoreLetter0(letter,word):
	if(vowels.find(letter)>0):
		return [-1,1]
	else:
		return [0,1]
func scoreWord0(word):
	return [0,2]
	
func scoreLetter1(letter:String,word:String):
	if(word.find(letter.to_upper(),word.find(letter.to_upper())+1)):
		return [0,3]
	else:
		return [0,1]
func scoreWord1(word):
	return [0,1]

func scoreLetter2(letter:String,word:String):
	return [0,1]
func scoreWord2(word):
	if(word.length()<=3):
		return [0,3]
	return [0,1]

func scoreLetter3(letter:String,word:String):
	return [0,1]
func scoreWord3(word):
	return [0,1]

func scoreLetter4(letter:String,word:String):
	if(vowels.find(letter)>0):
		return [1,1]
	return [0,1]
func scoreWord4(word):
	return [0,1]

func scoreLetter5(letter:String,word:String):
	return [0,2]
func scoreWord5(word):
	return [0,.5]

func scoreLetter6(letter:String,word:String):
	return [0,1]
func scoreWord6(word):
	#if last word of repeat score x2
	return [0,1]
