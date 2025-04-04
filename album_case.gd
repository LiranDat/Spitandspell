class_name AlbumCase extends Node2D
var time = 0.0
var albums = [null,null,null,null]
var albumCount = 0
const MAXSIZE = 4
var full = false
const positions = [Vector2(36,40),Vector2(108,40),Vector2(36,104),Vector2(108,104)]

func _ready():
	$Money.money = Globals.STARTINGMONEY
	
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
	if $Money.money >= album.price:
		$Money.money -= album.price
		addAlbum(album)
		print(albums)
		return true
	print(albums)
	return false
	pass
	
func addAlbum(album : Album):
	if(full):
		return
	albums[albumCount]=album
	album.reparent($Albums)
	var tween = album.create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(album,"position",positions[albumCount],1.0)
	albumCount += 1
	if(albumCount >= MAXSIZE):
		full = true
	pass

func sellAlbum(album:Album):
	$Money.money += album.price
	removeAlbum(album)

func removeAlbum(album : Album):
	for searchIndex in albums.size():
		if(albums[searchIndex]==album):
			albums[searchIndex]=null
	albumCount -=1
	full = false
	var ownedAlbums = [null,null,null,null]
	var index = 0
	for slot in albums.size():
		if(albums[slot] != null):
			ownedAlbums[index]=albums[slot]
			index+=1
	print("owning "+ str(ownedAlbums.size())+" albums")
	for slot in albums.size():
		if(ownedAlbums[slot] != null):
			print("moving album")
			albums[slot]=ownedAlbums[slot]
		else:
			albums[slot]=null
	for slot in albums.size():		
		if(albums[slot]):
			var tween = albums[slot].create_tween()
			tween.set_ease(Tween.EASE_IN_OUT)
			tween.set_trans(Tween.TRANS_ELASTIC)
			tween.tween_property(albums[slot],"position",positions[slot],1.0)
	print(albums)

func addMoney(money:float):
	$Money.money += money
