extends Node2D

var letterScene = preload("res://letter.tscn")
@export var letterAreaSize : Vector2i = Vector2i(5,2)

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

func _ready():
	createLetterDeck()
	$LetterArea/Shape.scale = Vector2(64.,64.)*Vector2(letterAreaSize)
	
	pass

func createLetterDeck():
	var letterDeck = []
	for letter in abc.keys():
		#print(letter + ": count [" + str(abc[letter][1]) +"] + score["+ str(abc[letter][0])+"]")
		for count in abc[letter][1]:
			var letterInstance = letterScene.instantiate()
			letterInstance.letter = letter
			letterInstance.score = abc[letter][0]
			$MicPos/LetterDeck.add_child(letterInstance)
			letterInstance.hide()
	pass
	
func distributeLetters(count):
	for index in range(count):
		var childCount = $MicPos/LetterDeck.get_child_count()
		if(childCount <= 0):
			return
		var childIndex = randi_range(0,$MicPos/LetterDeck.get_child_count()-1)
		var letter = $MicPos/LetterDeck.get_child(childIndex)
		letter.reparent($LetterArea)
		var tween = letter.create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(letter,"position",Vector2(64.0*float(index%letterAreaSize.x),64.0*float(index/letterAreaSize.y)),1.0)
		letter.show()
		$MicPos/Mic.pop()
		await get_tree().create_timer(0.2).timeout
	pass


func _on_timer_timeout() -> void:
	distributeLetters(10)
	pass # Replace with function body.
