extends Panel
@onready var letterScene = preload("res://letter.tscn")

func _ready():
	var AreaSize = Vector2i(13,2)
	var alphabet = Alphabet.getAlphabet()
	var letters = alphabet.keys()
	for letterIndex in letters.size():
		for count in alphabet[letters[letterIndex]][1]:
			var letterInstance = letterScene.instantiate()
			var xPos = 64.0*float(int(letterIndex%AreaSize.x))+32.0
			var size = 64.0*12.0+32.0
			xPos -= size/2.0
			print(size)
			var yPos = 80.0*float(int(letterIndex/AreaSize.x))+count*4.0
			letterInstance.position = Vector2(xPos,yPos)
			letterInstance.letter = letters[letterIndex]
			letterInstance.score = alphabet[letters[letterIndex]][0]
			$Control.add_child(letterInstance)


func _on_button_pressed() -> void:
	self.queue_free()
	pass # Replace with function body.
