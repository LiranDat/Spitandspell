class_name UsedWords extends Node

static var usedWordsDict = {
	
}

func getUsedWords():
	return usedWordsDict.duplicate()
	
func addWord(word):
	var newDict = usedWordsDict.duplicate()
	newDict[word] = newDict.get_or_add(word,1)
