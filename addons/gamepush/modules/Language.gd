extends Node

var window:JavaScriptObject
var gp:JavaScriptObject


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
			
			
# format ISO 639-1
func current() -> String:
	if OS.get_name() == "Web":
		return gp.language
	else:
		push_warning("Not running on Web")
		return ""

func change(lang:String) -> void:
	if OS.get_name() == "Web":
		gp.changeLanguage(lang)
	else:
		push_warning("Not running on Web")
