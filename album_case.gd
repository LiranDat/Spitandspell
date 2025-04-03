class_name AlbumCase extends Node2D
var time = 0.0
var albums = []
const MAXSIZE = 4
var full = false
const positions = [Vector2(36,40),Vector2(108,40),Vector2(36,104),Vector2(108,104)]

func _process(delta: float) -> void:
	$SignPolygon.skew = sin(time*.5)/100.0*2.0
	$SignPolygon2.skew = -sin(time*.5)/100.0*5.0
	for container in $Containers.get_children():
		container.skew = sin(time*.5)/100.0*5.0
	time += delta

func isFull():
	return full
	
func buyAlbum(album:Album):
	if $Money.money > album.price:
		$Money.money -= album.price
		addAlbum(album)
		print(albums.size())
	pass
	
func addAlbum(album : Album):
	if(full):
		return
	albums.append(album)
	album.reparent($Albums)
	var tween = album.create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(album,"position",positions[albums.size()-1],1.0)
	if(albums.size() >= MAXSIZE):
		full = true
	pass
