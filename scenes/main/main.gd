extends Node

var abc = { # [ Punkte, Häufigkeit ]
	"A": [1, 9],
	"B": [3, 2],
	"C": [3, 2],
	"D": [2, 4],
	"E": [1, 12],
	"F": [4, 2],
	"G": [2, 3],
	"H": [4, 2],
	"I": [1, 9],
	"J": [8, 1],
	"K": [5, 1],
	"L": [1, 4],
	"M": [3, 2],
	"N": [1, 6],
	"O": [1, 8],
	"P": [3, 2],
	"Q": [10, 1],
	"R": [1, 6],
	"S": [1, 4],
	"T": [1, 6],
	"U": [1, 4],
	"V": [4, 2],
	"W": [4, 2],
	"X": [8, 1],
	"Y": [4, 2],
	"Z": [10, 1]
}

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
	add_child(lyrics.instantiate())

func start_shop():
	add_child(shop.instantiate())

func _process(delta: float) -> void:
	pass
