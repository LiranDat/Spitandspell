extends Node2D

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


func scoreWord(word:String):
	var albumCase = get_tree().get_first_node_in_group("AlbumCase")
	var score = 0
	for letterIndex in word.length():
		var letter = word[letterIndex].to_upper()
		var letterSelection : LetterSelection = get_tree().get_first_node_in_group("LetterSelection")
		letterSelection.useLetter(letter)
		var letterScore = await albumCase.scoreLetter(letter,word)
		score += letterScore[0]+letterScore[1]*abc[letter][0]
		print("letter " + letter + " scored: "+ str(letterScore[0]+letterScore[1]*abc[letter][0]))
		await get_tree().create_timer(.1).timeout
	print("Raw Word score is: "+ str(score))
	var wordScore = await albumCase.scoreWord(word.to_upper())
	score = wordScore[0]+wordScore[1]*score
	print("Total score is: " + str(score))
	pass


func _on_button_pressed() -> void:
	print($Panel/TextEdit.text)
	scoreWord($Panel/TextEdit.text)
	pass # Replace with function body.
