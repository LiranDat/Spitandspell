extends RichTextLabel

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

var all_words = []
var current_word = ""
var current_sum = 0
var total_sum = 0
var past_word

func _ready() -> void:
	past_word = preload("res://scenes/past_word/past_word.tscn")

func score_letter(letter: String) -> int:
	return abc[letter][0]

func score():
	for letter in current_word:
		current_sum += score_letter(letter)
	total_sum += current_sum
	current_sum = 0
	
	var instance = past_word.instantiate()
	instance.text = current_word
	add_child(instance)
	
	all_words.append(current_word)
	current_word = ""

func _input(event):
	if event.as_text() in abc and event.pressed:
		current_word += event.as_text()
	elif event.as_text() == "Space":
		score()

func _process(delta: float) -> void:
	self.text = current_word
