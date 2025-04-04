extends Node2D

func _ready():
	Alphabet.setAlphabet(Alphabet.BASEALPHABET)
	$LetterSelection.distributeLetters(10)
func scoreWord(word:String) ->int:
	var alphabet = Alphabet.getAlphabet()
	var albumCase = get_tree().get_first_node_in_group("AlbumCase")
	var score = 0
	var letterScores = []
	var letterSelection : LetterSelection = get_tree().get_first_node_in_group("LetterSelection")
	if(!WordTest.testWord(word.to_upper())):
		return 0
	for letterIndex in word.length():
		var letter = word[letterIndex].to_upper()		
		var letterScore = [0,0]
		if letterSelection.useLetter(letter):
			letterScore = await albumCase.scoreLetter(letter,word)
		score += letterScore[0]+letterScore[1]*alphabet[letter][0]
		letterScores.push_back([letter,letterScore[0]+letterScore[1]*alphabet[letter][0]])
		await get_tree().create_timer(.1).timeout
	var rawWordScore = score
	var wordScore = await albumCase.scoreWord(word.to_upper())
	score = (wordScore[0]+wordScore[1])*score
	printScore(word,letterScores,rawWordScore,score)
	await get_tree().create_timer(0.5).timeout
	letterSelection.refreshLetters()
	return int(score)
	pass
	
func printScore(word,letterScores,rawWordScore,score):
	print("Word: "+ word.to_upper())
	print("Word scores: " + str(letterScores))
	print("Raw word score: " + str(rawWordScore))
	print("Total score: " + str(int(score)))

func _on_button_pressed() -> void:
	print($Panel/TextEdit.text)
	scoreWord($Panel/TextEdit.text)
	if(WordTest.testBadWord($Panel/TextEdit.text)):
		print($Panel/TextEdit.text + " is bad word")
	pass # Replace with function body.
