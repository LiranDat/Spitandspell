extends RichTextLabel

@onready var abc = get_parent().abc

var current_word = ""
var current_sum = 0
var total_sum = 0
var past_word
var new_score
var timer = 1
var fire

# Arrangement
var words_per_round = 2
var rounds_per_shop = 2
var word_count = 0
var round_count = 0

# TTS
var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[0]

func _ready() -> void:
	past_word = preload("res://scenes/past_word/past_word.tscn")
	new_score = preload("res://scenes/new_score/new_score.tscn")
	fire = preload("res://scenes/fire/fire.tscn")

func score_letter(letter: String) -> int:
	return abc[letter][0]

func word_exists(word: String) -> bool:
	var file = FileAccess.open("res://wordlist/wordlist-20210729.txt", FileAccess.READ)
	var content = file.get_as_text()
	var searchString = "\"" + word + "\""
	if(content.findn(searchString)>0):
		return true
	return false

func score():
	current_sum = 0
	
	if word_exists(current_word):
		for letter in current_word:
			current_sum += score_letter(letter)
		
		var instance1 = new_score.instantiate()
		instance1.text = "+" + str(current_sum)
		add_child(instance1)
		
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
	
	$score_label.text = str(total_sum)
	
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
	if event.as_text() in abc and event.pressed:
		current_word += event.as_text()
	elif event.as_text() == "Space" and event.pressed:
		score()
	elif event.as_text() == "Backspace" and event.pressed:
		current_word = current_word.left(-1)

func _process(delta: float) -> void:
	self.text = current_word
	
	if timer > 0:
		timer -= delta
	else:
		score()
		timer = 3
	
	$timer_bar.size.x = 10 * timer
