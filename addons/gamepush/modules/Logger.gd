extends Node

var window: JavaScriptObject
var gp: JavaScriptObject

signal after_ready

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
	after_ready.emit()
		
			
func info(...args:Array) -> void:
	info_array(args)


func warn(...args:Array) -> void:
	warn_array(args)


func error(...args:Array) -> void:
	error_array(args)


func log(...args:Array) -> void:
	var res:= ""
	for a in args:
		res += str(a)
		res += " "
	res.strip_edges()
	if OS.get_name() == "Web":
		gp.logger.log(res)
	else:
		print(res)
		
		
func info_array(args:Array) -> void:
	var res:= ""
	for a in args:
		res += str(a)
		res += " "
	res.strip_edges()
	if OS.get_name() == "Web":
		gp.logger.info(res)
	else:
		print("INFO:", res)

func warn_array(args:Array) -> void:
	var res:= ""
	for a in args:
		res += str(a)
		res += " "
	res.strip_edges()
	if OS.get_name() == "Web":
		gp.logger.warn(res)
	else:
		push_warning(res)
		
func error_array(args:Array) -> void:
	var res:= ""
	for a in args:
		res += str(a)
		res += " "
	res.strip_edges()
	if OS.get_name() == "Web":
		gp.logger.error(res)
	else:
		push_error(res)
