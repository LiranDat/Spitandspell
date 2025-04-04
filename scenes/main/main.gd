extends Node

var target_scores = [10, 20, 40, 80, 160, 320]
var level_counter = -1
var money = 0

# Szenen
var lyrics = preload("res://scenes/lyrics/lyrics.tscn")
var shop = preload("res://shop.tscn")
var start_button = preload("res://scenes/start_button/start_button.tscn")

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

func start_shop():
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
	
	$boo.play()
