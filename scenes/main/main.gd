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
	level_counter += 1
	var level = lyrics.instantiate()
	add_child(level)
	level.target_score = target_scores[level_counter]
	$music.play()
	$music.volume_db = -1
	$boombox.bounce()

func start_shop():
	add_child(shop.instantiate())
	$music.volume_db = -7

func _process(delta: float) -> void:
	pass
