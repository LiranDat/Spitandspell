@tool
extends Node2D
@export_tool_button("Text-To-Speech") var ttsAction = tts

func tts():
	var voices = DisplayServer.tts_get_voices_for_language("en")
	var voice_id = voices[0]
	DisplayServer.tts_speak("Go with the flow", voice_id)
	pass
