extends Node

var target_scores = [10, 20, 40, 80, 160, 320, 640, 1280, 2560, 5120]
var level_counter = -1

# Szenen
var lyrics = preload("res://scenes/lyrics/lyrics.tscn")
var shop = preload("res://shop.tscn")
var start_button = preload("res://scenes/start_button/start_button.tscn")

var last_score = 0

func _ready() -> void:
	var button = start_button.instantiate()
	add_child(button)
	button.position.x = 500
	button.position.y = 300

func start_lyrics():
	$info.visible = false
	$title.visible = false
	level_counter += 1
	var level = lyrics.instantiate()
	add_child(level)
	level.target_score = target_scores[level_counter]
	$music.volume_db = -1
	$LetterSelection.distributeLetters(10)

func win():
	$restart_button.visible = true
	$title.visible = true
	$win_lose.visible = true
	$win_lose.text = "You won!\nYour flow is truly sick!"

func start_shop():
	
	if level_counter == 9:
		win()
		return
	
	var case = get_tree().get_first_node_in_group("AlbumCase")
	if(case):
		case.addMoney(10+level_counter*2)
	var ding = shop.instantiate()
	add_child(ding)
	
	ding.position.x = 200
	ding.position.y = 200
	$music.volume_db = -7

func close_shop():
	$music.stop()
	start_lyrics()

func lose():
	var tween = get_tree().create_tween()
	tween.tween_property($music, "pitch_scale", 0, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	$restart_button.visible = true
	$title.visible = true
	$win_lose.visible = true
	
	$boo.play()
