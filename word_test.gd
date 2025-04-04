class_name WordTest extends Control
var word : String
var letterScene = preload("res://letter.tscn")
var letters : = []
static var prefixTable = loadDict(PREFIXFILE)

const LETTERCHARACTERS = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
const WORDFILE = "res://wordlist/wordlist-20210729.txt"
const BADWORDFILE = "res://wordlist/badwords.txt"
const PREFIXFILE = "res://wordlist/prefixes_precalc.txt"

func _ready():
	prefixPreLoad()
	pass
	
static func testWord(word):
	return testWordIndex(word)>=0

static func testWordIndex(word:String):
	var file = FileAccess.open(WORDFILE, FileAccess.READ)
	var content = file.get_as_text()
	var searchString = "\"" + word.to_upper() + "\""
	var prefixPos = getPrefixPos(word)
	var searchIndex = -1
	if(prefixPos):
		searchIndex = content.findn(searchString,getPrefixPos(word))
	return searchIndex
	
static func testBadWord(word):
	var file = FileAccess.open(BADWORDFILE, FileAccess.READ)
	while not file.eof_reached():
		var badWord = file.get_line()
		if(badWord.findn(word)==0):
			return true
	return false
func _process(delta):
	if($Panel/TextEdit.text != word):
		word = $Panel/TextEdit.text
		var file = FileAccess.open(WORDFILE, FileAccess.READ)
		var content = file.get_as_text()
		var searchString = "\"" + word + "\""
		var prefixPos = getPrefixPos(word)
		var searchIndex = -1
		if(prefixPos):
			searchIndex = content.findn(searchString,getPrefixPos(word))
		
		if(searchIndex>0):
			$Panel/RichTextLabel.text = word.to_upper()
			if($Panel/Letters.get_child_count()>0):
				$Panel/Letters.get_child(0).queue_free()
			var WordNode = Node2D.new()
			$Panel/Letters.add_child(WordNode)
			for i in word.length():
				var letterNode = letterScene.instantiate()
				letterNode.letter = word[i].to_upper()
				letterNode.position.x = 36*i
				letterNode.score = "1"
				WordNode.add_child(letterNode)
				letters.append(letterNode)
	pass
		
	
static func getPrefix(word : String):
	if(word.length()):
		var l = min(2,word.length())
		return word.substr(0,l)
	return -1

static func getPrefixPos(word : String):
	if(word.length()):
		return prefixTable[getPrefix(word)]

static func prefixPreLoad():
	prefixTable = loadDict(PREFIXFILE)
	pass

func prefixPreCalculate():
	var file = FileAccess.open(WORDFILE, FileAccess.READ)
	var content = file.get_as_text()
	for letter in LETTERCHARACTERS:
		var searchString = "\"" + letter
		var searchIndex = content.findn(searchString)
		prefixTable[letter] = searchIndex
		prefixTable[letter.to_upper()] = searchIndex
		for letter2 in LETTERCHARACTERS:
			searchString = "\"" + letter + letter2
			searchIndex = content.findn(searchString)
			prefixTable[letter+letter2] = searchIndex
			prefixTable[(letter+letter2).to_upper()] = searchIndex
	storeDict(PREFIXFILE, prefixTable)
	pass

func storeDict(filePath, dict):
	var file = FileAccess.open(filePath,FileAccess.WRITE)
	for i in prefixTable.size():
		file.store_line(str(prefixTable.keys()[i],":",prefixTable.values()[i],"\r").replace(" ","")) 
	file.close()
	pass
	
static func loadDict(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = {}
	for i in file.get_as_text().count(":"):
		var line = file.get_line()
		var key = line.split(":")[0]
		var value = line.split(":")[1]
		content[key] = int(value)
	file.close()
	return content
