extends Node2D

func scoreWord(word:String):
	var alphabet = Alphabet.getAlphabet()
	var albumCase = get_tree().get_first_node_in_group("AlbumCase")
	var score = 0
	for letterIndex in word.length():
		var letter = word[letterIndex].to_upper()
		var letterSelection : LetterSelection = get_tree().get_first_node_in_group("LetterSelection")
		letterSelection.useLetter(letter)
		var letterScore = await albumCase.scoreLetter(letter,word)
		score += letterScore[0]+letterScore[1]*alphabet[letter][0]
		print("letter " + letter + " scored: "+ str(letterScore[0]+letterScore[1]*alphabet[letter][0]))
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
