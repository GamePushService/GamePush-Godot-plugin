extends Node

const VERSION = "2.0.1"

@onready var achievements := preload("res://addons/gamepush/modules/Achievements.gd").new()
@onready var ads := preload("res://addons/gamepush/modules/Ads.gd").new()
@onready var analytics := preload("res://addons/gamepush/modules/Analytics.gd").new()
@onready var triggers := preload("res://addons/gamepush/modules/Triggers.gd").new()
@onready var app := preload("res://addons/gamepush/modules/App.gd").new()
@onready var avatar_generator := preload("res://addons/gamepush/modules/AvatarGenerator.gd").new()
@onready var channels := preload("res://addons/gamepush/modules/Channels.gd").new()
@onready var device := preload("res://addons/gamepush/modules/Device.gd").new()
@onready var documents := preload("res://addons/gamepush/modules/Documents.gd").new()
@onready var events := preload("res://addons/gamepush/modules/Events.gd").new()
@onready var experiments := preload("res://addons/gamepush/modules/Experiments.gd").new()
@onready var fullscreen := preload("res://addons/gamepush/modules/Fullscreen.gd").new()
@onready var files := preload("res://addons/gamepush/modules/Files.gd").new()
@onready var game := preload("res://addons/gamepush/modules/Game.gd").new()
@onready var games_collections := preload("res://addons/gamepush/modules/GameCollections.gd").new()
@onready var images := preload("res://addons/gamepush/modules/Images.gd").new()
@onready var language := preload("res://addons/gamepush/modules/Language.gd").new()
@onready var leaderboard := preload("res://addons/gamepush/modules/Leaderboard.gd").new()
@onready var logger := preload("res://addons/gamepush/modules/Logger.gd").new()
@onready var payments := preload("res://addons/gamepush/modules/Payments.gd").new()
@onready var platform := preload("res://addons/gamepush/modules/Platform.gd").new()
@onready var player := preload("res://addons/gamepush/modules/Player.gd").new()
@onready var players := preload("res://addons/gamepush/modules/Players.gd").new()
@onready var rewards := preload("res://addons/gamepush/modules/Rewards.gd").new()
@onready var schedulers := preload("res://addons/gamepush/modules/Schedulers.gd").new()
@onready var segments := preload("res://addons/gamepush/modules/Segments.gd").new()
@onready var server := preload("res://addons/gamepush/modules/Server.gd").new()
@onready var socials := preload("res://addons/gamepush/modules/Socials.gd").new()
@onready var system := preload("res://addons/gamepush/modules/System.gd").new()
@onready var variables := preload("res://addons/gamepush/modules/Variables.gd").new()
@onready var uniques := preload("res://addons/gamepush/modules/Uniques.gd").new()
@onready var storage := preload("res://addons/gamepush/modules/Storage.gd").new()
@onready var sounds := preload("res://addons/gamepush/modules/Sounds.gd").new()
@onready var windows := preload("res://addons/gamepush/modules/Windows.gd").new()


var gp:JavaScriptObject

signal inited(success:bool)
var is_inited := false


func _ready():
	var is_init := false
	if !OS.get_name() == "Web":
		inited.emit(is_init)
		is_inited = true
		push_warning("Not running on Web")
		return
	var project_id := str(ProjectSettings.get_setting("game_push/config/project_id"))
	var public_token := ProjectSettings.get_setting("game_push/config/token")
	var clbk := JavaScriptBridge.create_callback(func(args):
		gp = args[0]
		is_init = true)
	var win := JavaScriptBridge.get_interface("window")
	win.setGpInitCallback(clbk)
	var lib_url := "https://gs.eponesh.com/sdk/gamepush.js?projectId=%s&publicToken=%s&callback=onGPInit" % [project_id, public_token]
	var js_code = "var script = document.createElement('script'); script.src = '" + lib_url + "'; document.head.appendChild(script);"
	JavaScriptBridge.eval(js_code, true)
	while not gp:
		await get_tree().create_timer(0.1).timeout
	
	for prop in get_property_list():
		var module_node = get(prop.name)
		if module_node is Node:
			add_child(module_node)
	await get_tree().create_timer(0.1).timeout
	
	var timer := Timer.new()
	var is_preloader_show := ProjectSettings.get_setting("game_push/config/is_preloader_show", false)
	var ready_delay := ProjectSettings.get_setting("game_push/config/ready_delay", 0.0)
	if is_preloader_show:
		ads.show_preloader()
	if ready_delay > 0.0:
		add_child(timer)
		timer.timeout.connect(_on_timer_timeout)
		timer.start(ready_delay)
	elif ready_delay == 0.0:
		_on_timer_timeout()
	
	inited.connect(func(is_init): is_inited = true)
	inited.emit(is_init)
	

func _on_timer_timeout():
	game.game_start()
	
	
func _js_to_dict(js_object:JavaScriptObject) -> Variant:
	var window := JavaScriptBridge.get_interface("window")
	var strn = window.JSON.stringify(js_object)
	var dict = JSON.parse_string(strn)
	return _re_snake(dict)


func _re_snake(data:Variant) -> Variant:
	var new_data = data
	if data is Dictionary:
		new_data = {}
		for k in data:
			if k is String:
				var k_snake = k.to_snake_case()
				new_data[k_snake] = _re_snake(data[k])
	elif data is Array:
		new_data = []
		for e in data:
			new_data.append(_re_snake(e))
	elif data is float:
		if data == int(data):
			new_data = int(data)
	return new_data
