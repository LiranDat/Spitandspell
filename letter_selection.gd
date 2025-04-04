class_name LetterSelection extends Node2D

var letterScene = preload("res://letter.tscn")
@export var letterAreaSize : Vector2i = Vector2i(5,2)
var count = 0

var usableLetters = []

func _ready():
	$LetterArea/Shape.hide()
	count = letterAreaSize.x*letterAreaSize.y
	createLetterDeck(Alphabet.getAlphabet())
	$LetterArea/Shape.scale = Vector2(64.,64.)*Vector2(letterAreaSize)
	pass

func createLetterDeck(alphabet:Dictionary):
	var letterDeck = []
	for letter in alphabet.keys():
		#print(letter + ": count [" + str(alphabet[letter][1]) +"] + score["+ str(alphabet[letter][0])+"]")
		for count in alphabet[letter][1]:
			var letterInstance = letterScene.instantiate()
			letterInstance.letter = letter
			letterInstance.score = alphabet[letter][0]
			$MicPos/LetterDeck.add_child(letterInstance)
			letterInstance.hide()
	pass
	
func distributeLetters(count):
	usableLetters.clear()
	while $LetterArea/Letters.get_child_count()>0:
		var letter = $LetterArea/Letters.get_child(0)
		letter.reparent($MicPos/LetterDeck)
		letter.hide()
		letter.position = Vector2(0.0,0.0)
	var letters = []
	for index in range(count):
		var childCount = $MicPos/LetterDeck.get_child_count()
		if(childCount <= 0):
			return
		var childIndex = randi_range(0,$MicPos/LetterDeck.get_child_count()-1)
		var letter = $MicPos/LetterDeck.get_child(childIndex)
		letters.append(letter)
		letter.reparent($LetterArea/Letters)
	letters.sort_custom(lettersort)
	for index in range(letters.size()):
		var letter = letters[index]
		usableLetters.append(letter)
		var tween = letter.create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_ELASTIC)
		var xPos = 64.0*float(int(index%letterAreaSize.x))+32.0
		var yPos = 64.0*float(int(index/letterAreaSize.x))+16.0
		tween.tween_property(letter,"position",Vector2(xPos,yPos),1.0)
		letter.show()
		$MicPos/Mic.pop()
		await get_tree().create_timer(0.1).timeout
	pass

func lettersort(a:Letter,b:Letter):
	return a.letter <= b.letter

func getUsableLetters():
	return usableLetters
	
func useLetter(l : String):
	if($LetterArea/Letters and $LetterArea/Letters.get_child_count()>0):
		for letter in $LetterArea/Letters.get_children():
			if letter.letter == l.to_upper() and letter.used == false:
				letter.used = true
				return true
	return false

func refreshLetters():
	if($LetterArea/Letters and $LetterArea/Letters.get_child_count()>0):
		for letter in $LetterArea/Letters.get_children():
				letter.used = false
		
func _on_timer_timeout() -> void:
	#distributeLetters(count)
	pass # Replace with function body.
