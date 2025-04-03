@tool
extends Node2D
@export_tool_button("Parse all Albums") var albumparse_action = parseAlbums

func parseAlbums():
	var albums = []
	var array : Array
	var parser = XMLParser.new()
	parser.open("res://albums.xml")
	while parser.read() != ERR_FILE_EOF:
		if parser.get_node_type() == XMLParser.NODE_ELEMENT:
			var node_name = parser.get_node_name()
			print(node_name)
			if parser.get_node_name()=="album":
				array = []
				albums.append(array)
			
			#print("The ", node_name, " element has the following attributes: " , attributes_dict)
			print(albums)
	pass

func oldparse():
	var words = []
	var doc : XMLDocument
	for letter in ["a"]:
		var letterwords = []
		doc = XML.parse_file("dicts/gcide_"+letter+".xml")
		for node in doc.root.children:
			var entry = ""
			var def = ""
			for part in node.children:
				if(part.to_dict()["__name__"]=="ent"):
					entry = part.content
				if(part.to_dict()["__name__"]=="def"):
					def = part.content
			if(entry.length()>0 && def.length()>0):
				letterwords.append([entry,def])
		words.append(letterwords)
	print(words)

<p><ent>0</ent><br/>
<hw>0</hw> <pos>adj.</pos> <sn>1.</sn>  <def>indicating the absence of any or all units under consideration; -- representing the number zero as an Arabic numeral</def><br/>
<syn><b>Syn. --</b> zero</syn><br/>
[<source>WordNet 1.5</source> <source>+PJC</source>]</p>
