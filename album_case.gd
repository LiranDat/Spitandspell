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
	
func scoreLetter(letter : String, word : String):
	var score = [0,1]
	for album in albums:
		if(album):
			var albumScore = await album.scoreLetter(letter,word)
			score = [score[0]+albumScore[0],score[1]*albumScore[1]]
	return score
	pass

func scoreWord(word : String):
	var score = [0,1]
	for album in albums:
		if(album):
			var albumScore = await album.scoreWord(word)
			score = [score[0]+albumScore[0],score[1]*albumScore[1]]
	return score
	pass

func buyAlbum(album:Album):
	if $Money.money > album.price:
		$Money.money -= album.price
		addAlbum(album)
		return true
	return false
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

func sellAlbum(album:Album):
	if $Money.money > album.price:
		$Money.money += album.price
	removeAlbum(album)

func removeAlbum(album : Album):
	if(albums.find(album)>0):
		print(albums.find(album))
		albums[albums.find(album)]=null
	full = false
	var ownedAlbums = []
	while(albums.size()>0):
		if(albums[0]!=null):
			ownedAlbums.push_back(albums[0])
		albums.pop_front()
	print(ownedAlbums.size())
	albums.clear()
	for ownedAlbum in ownedAlbums:
		addAlbum(ownedAlbum)
	
