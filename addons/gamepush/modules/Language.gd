extends Node

var window:JavaScriptObject
var gp:JavaScriptObject

signal after_ready

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
	after_ready.emit()
			
			
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
