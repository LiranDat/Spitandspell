@tool
extends Node2D
@export_tool_button("Parse all Albums") var albumparse_action = parseAlbums
const ALBUMFILE = "res://albums.xml"
const ALBUMATTRIBUTES = ["id","title","description","subdescript","price"]

func parseAlbums():
	var doc : XMLDocument
	var albums = []
	doc = XML.parse_file(ALBUMFILE)
	for node in doc.root.children:
		var album = {}
		for part in node.children:
			for attribute in ALBUMATTRIBUTES:
				if(part.to_dict()["__name__"]==attribute):
					album[attribute] = part.content
		albums.append(album)
	print(albums)
	pass
