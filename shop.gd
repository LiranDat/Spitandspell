extends Node2D
var albumScene = preload("res://album.tscn")
signal shop_closed

func _ready():
	for album in $Albums.get_children():
		album.queue_free()
		await album.tree_exited
	for i in range(3):
		var album = albumScene.instantiate()
		album.albumNumber=randi_range(0,Globals.ALBUMCOUNT) 
		album.updateAlbumInfo()
		album.position = Vector2((float(i%3)-1)*80.0,float(i/3)*80.0+40.)
		$Albums.add_child(album)
	pass

func _process(delta: float) -> void:
	$Visuals/StorePolygon.skew = sin(Globals.time*.5)/100.0*2.0
	$Visuals/SignPolygon.skew = -sin(Globals.time*.5)/100.0*5.0
	for index in $Visuals/Letters.get_child_count():
		var letter = $Visuals/Letters.get_child(index)
		letter.position.y = sin(Globals.time+float(index)*PI/13.0)*6.0
		letter.rotation = sin(Globals.time+float(index)*PI/1.7)/10.0/PI
	
	if $close_button.button_pressed:
		if(get_parent().has_method("close_shop")):
			get_parent().close_shop()
		queue_free()


func _on_close_shop(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_parent().close_shop()
			self.queue_free()
