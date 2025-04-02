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
