extends Node2D
var time = 0.0
var albumScene = preload("res://album.tscn")

func _ready():
	for i in range(3):
		var album = albumScene.instantiate()
		album.albumNumber=randi_range(3,Globals.ALBUMCOUNT) 
		album.updateAlbumInfo()
		album.position = Vector2((float(i%3)-1)*80.0,float(i/3)*80.0+40.)
		$Albums.add_child(album)
	pass

func _process(delta: float) -> void:
	$Visuals/StorePolygon.skew = sin(time*.5)/100.0*2.0
	$Visuals/SignPolygon.skew = -sin(time*.5)/100.0*5.0
	for index in $Visuals/Letters.get_child_count():
		var letter = $Visuals/Letters.get_child(index)
		letter.position.y = sin(time+float(index)*PI/13.0)*6.0
		letter.rotation = sin(time+float(index)*PI/1.7)/10.0/PI
	time += delta
	pass
