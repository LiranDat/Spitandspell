extends Control
var word : String
func _process(delta):
	if($Panel/TextEdit.text != word):
		word = $Panel/TextEdit.text
		var file = FileAccess.open("res://wordlist/wordlist-20210729.txt", FileAccess.READ)
		var content = file.get_as_text()
		var searchString = "\"" + word + "\""
		if(content.find(searchString)>0):
			print("Word found: " + word + " " + str(content.find(word)))
			$Panel/RichTextLabel.text = word
	pass
