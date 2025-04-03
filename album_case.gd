class_name AlbumCase extends Node2D
var time = 0.0
var albums = []
const positions = [Vector2(36,40),Vector2(108,40),Vector2(36,104),Vector2(108,104)]

func _process(delta: float) -> void:
	$SignPolygon.skew = sin(time*.5)/100.0*2.0
	$SignPolygon2.skew = -sin(time*.5)/100.0*5.0
	for container in $Containers.get_children():
		container.skew = sin(time*.5)/100.0*5.0
	time += delta

func addAlbum(album : Album):
	albums.append(album)
	album.reparent($Albums)
	var tween = album.create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(album,"position",positions[albums.size()-1],1.0)
	pass
