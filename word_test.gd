extends Control
var word : String
var letterScene = preload("res://letter.tscn")
var letters : = []

func _process(delta):
	if($Panel/TextEdit.text != word):
		word = $Panel/TextEdit.text
		var file = FileAccess.open("res://wordlist/wordlist-20210729.txt", FileAccess.READ)
		var content = file.get_as_text()
		var searchString = "\"" + word + "\""
		if(content.findn(searchString)>0):
			print("Word found: " + word + " " + str(content.find(word)))
			$Panel/RichTextLabel.text = word.to_upper()
			$Panel.get_child(3).queue_free()
			var WordNode = Node2D.new()
			$Panel.add_child(WordNode)
			for i in word.length():
				var letterNode = letterScene.instantiate()
				letterNode.letter = word[i].to_upper()
				letterNode.position.x = 36*i
				letterNode.score = "1"
				WordNode.add_child(letterNode)
				letters.append(letterNode)
			var voices = DisplayServer.tts_get_voices_for_language("en")
			var voice_id = voices[0]
			DisplayServer.tts_speak(word, voice_id)
	pass
