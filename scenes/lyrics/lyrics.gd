extends RichTextLabel

@onready var alphabet = Alphabet.getAlphabet()

var current_word = ""
var current_sum = 0
var total_sum = 0
var past_word
var new_score
var timer = 2.4
var fire
var scoring_word = ""

# benötigte Punkte
var target_score = 0

# Arrangement
var words_per_round = 8
var rounds_per_shop = 1
var word_count = 0
var round_count = 0
var round_active = false

# TTS
var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[0]

func _ready() -> void:
	past_word = preload("res://scenes/past_word/past_word.tscn")
	new_score = preload("res://scenes/new_score/new_score.tscn")
	fire = preload("res://scenes/fire/fire.tscn")
	$metronome.count()

func score_letter_old(letter: String) -> int:
	return alphabet[letter][0]

func score_word(word:String) ->int:
	var alphabet = Alphabet.getAlphabet()
	var albumCase = get_tree().get_first_node_in_group("AlbumCase")
	var score = 0
	var letterScores = []
	var letterSelection : LetterSelection = get_tree().get_first_node_in_group("LetterSelection")
	for letterIndex in word.length():
		var letter = word[letterIndex].to_upper()
		var letterScore = [0,0]
		if letterSelection.useLetter(letter):
			letterScore = await albumCase.scoreLetter(letter,word)
		score += letterScore[0]+letterScore[1]*alphabet[letter][0]
		letterScores.push_back([letter,letterScore[0]+letterScore[1]*alphabet[letter][0]])
		#await get_tree().create_timer(.1).timeout
	var rawWordScore = score
	var wordScore = await albumCase.scoreWord(word.to_upper())
	score = wordScore[0]+wordScore[1]*score
	await get_tree().create_timer(0.5).timeout
	letterSelection.refreshLetters()
	return int(score)

func score():
	
	# boombox bounce
	$"../boombox".bounce()
	
	current_sum = 0
	scoring_word = current_word
	
	var instance = past_word.instantiate()
	instance.text = current_word
	add_child(instance)
	
	DisplayServer.tts_speak(scoring_word, voice_id)
	
	current_word = ""
	
	if WordTest.testWord(scoring_word):
		current_sum = await score_word(scoring_word)
		
		var instance1 = new_score.instantiate()
		instance1.text = "+" + str(current_sum)
		add_child(instance1)
		instance1.position.y = 20
		instance1.position.x = 200
		
		total_sum += current_sum
		
		if current_sum > (target_score / 2):
			$ooh.play()
			add_child(fire.instantiate())
	
	else:
		var instance1 = new_score.instantiate()
		instance1.text = "FAIL"
		add_child(instance1)
	
	word_count += 1
	if word_count == words_per_round:
		round_count += 1
		word_count = 0
	
	if round_count == rounds_per_shop:
		end_round()

func end_round():
	if total_sum < target_score:
		get_parent().lose()
	else:
		get_parent().last_score = total_sum
		get_parent().start_shop()
	self.queue_free()

func _input(event):
	if event.as_text() in alphabet and event.pressed and round_active:
		current_word += event.as_text()
	elif event.as_text() == "Backspace" and event.pressed and round_active:
		current_word = current_word.left(-1)

func _process(delta: float) -> void:
	self.text = current_word
	$score_label.text = str(total_sum) + " / " + str(target_score * (round_count + 1))
	
	if timer > 0:
		timer -= delta
	else:
		if round_active:
			score()
		else:
			round_active = true
			$"../music".play()
			$"../boombox".bounce()
		timer = 2.4
	
	$timer_bar.value = timer
