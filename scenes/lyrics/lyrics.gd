extends RichTextLabel

@onready var alphabet = Alphabet.getAlphabet()

var current_word = ""
var current_sum = 0
var total_sum = 0
var past_word
var new_score
var timer = 2.4
var fire

# benötigte Punkte
var target_score = 0

# Arrangement
var words_per_round = 4
var rounds_per_shop = 3
var word_count = 0
var round_count = 0

# TTS
var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[0]

func _ready() -> void:
	past_word = preload("res://scenes/past_word/past_word.tscn")
	new_score = preload("res://scenes/new_score/new_score.tscn")
	fire = preload("res://scenes/fire/fire.tscn")

func score_letter_old(letter: String) -> int:
	return alphabet[letter][0]

func word_exists(word: String) -> bool:
	var file = FileAccess.open("res://wordlist/wordlist-20210729.txt", FileAccess.READ)
	var content = file.get_as_text()
	var searchString = "\"" + word + "\""
	if(content.findn(searchString)>0):
		return true
	return false

func score_word(word:String):
	var alphabet = Alphabet.getAlphabet()
	var album_case = get_tree().get_first_node_in_group("AlbumCase")
	var score = 0
	var letter_scores = []
	var letter_selection : LetterSelection = get_tree().get_first_node_in_group("LetterSelection")
	for letter_index in word.length():
		var letter = word[letter_index].to_upper()
		var letterScore = [0,0]
		if letter_selection.useLetter(letter):
			letterScore = await album_case.scoreLetter(letter,word)
		score += letterScore[0]+letterScore[1]*alphabet[letter][0]
		letter_scores.push_back([letter,letterScore[0]+letterScore[1]*alphabet[letter][0]])
		await get_tree().create_timer(.1).timeout
	var rawWordScore = score
	var word_score = await album_case.scoreWord(word.to_upper())
	score = word_score[0]+word_score[1]*score
	#printScore(word,letterScores,rawWordScore,score)
	letter_selection.refreshLetters()

func score_old():
	
	# boombox bounce
	$"../boombox".bounce()
	
	current_sum = 0
	
	if word_exists(current_word):
		for letter in current_word:
			current_sum += score_letter_old(letter)
		
		var instance1 = new_score.instantiate()
		instance1.text = "+" + str(current_sum)
		add_child(instance1)
		instance1.position.y = 20
		instance1.position.x = 200
		
		total_sum += current_sum
		
		if current_sum > 9:
			$ooh.play()
			add_child(fire.instantiate())
	
	else:
		var instance1 = new_score.instantiate()
		instance1.text = "FAIL"
		add_child(instance1)
	
	var instance = past_word.instantiate()
	instance.text = current_word
	add_child(instance)
	
	DisplayServer.tts_speak(current_word, voice_id)
	
	word_count += 1
	if word_count == words_per_round:
		round_count += 1
		word_count = 0
	
	if round_count == rounds_per_shop:
		end_round()
	
	current_word = ""

func end_round():
	get_parent().start_shop()
	self.queue_free()

func _input(event):
	if event.as_text() in alphabet and event.pressed:
		current_word += event.as_text()
	elif event.as_text() == "Space" and event.pressed:
		score_old()
	elif event.as_text() == "Backspace" and event.pressed:
		current_word = current_word.left(-1)

func _process(delta: float) -> void:
	self.text = current_word
	$score_label.text = str(total_sum) + " / " + str(target_score * (round_count + 1))
	
	if timer > 0:
		timer -= delta
	else:
		score_old()
		timer = 2.4
	
	$timer_bar.value = timer
