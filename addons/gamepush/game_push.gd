extends Node

@onready var Achievements := preload("res://addons/gamepush/modules/Achievements.gd").new()
@onready var Ads := preload("res://addons/gamepush/modules/Ads.gd").new()
@onready var Analytics := preload("res://addons/gamepush/modules/Analytics.gd").new()
@onready var Triggers := preload("res://addons/gamepush/modules/Triggers.gd").new()
@onready var App := preload("res://addons/gamepush/modules/App.gd").new()
@onready var AvatarGenerator := preload("res://addons/gamepush/modules/AvatarGenerator.gd").new()
@onready var Channels := preload("res://addons/gamepush/modules/Channels.gd").new()
@onready var Device := preload("res://addons/gamepush/modules/Device.gd").new()
@onready var Documents := preload("res://addons/gamepush/modules/Documents.gd").new()
@onready var Events := preload("res://addons/gamepush/modules/Events.gd").new()
@onready var Experiments := preload("res://addons/gamepush/modules/Experiments.gd").new()
@onready var Fullscreen := preload("res://addons/gamepush/modules/Fullscreen.gd").new()
@onready var Game := preload("res://addons/gamepush/modules/Game.gd").new()
@onready var GamesCollections := preload("res://addons/gamepush/modules/GameCollections.gd").new()
@onready var Images := preload("res://addons/gamepush/modules/Images.gd").new()
@onready var Language := preload("res://addons/gamepush/modules/Language.gd").new()
@onready var Leaderboard := preload("res://addons/gamepush/modules/Leaderboard.gd").new()
@onready var LeaderboardScoped := preload("res://addons/gamepush/modules/LeaderboardScoped.gd").new()
@onready var Payments := preload("res://addons/gamepush/modules/Payments.gd").new()
@onready var Platform := preload("res://addons/gamepush/modules/Platform.gd").new()
@onready var Player := preload("res://addons/gamepush/modules/Player.gd").new()
@onready var Players := preload("res://addons/gamepush/modules/Players.gd").new()
@onready var Rewards := preload("res://addons/gamepush/modules/Rewards.gd").new()
@onready var Schedulers := preload("res://addons/gamepush/modules/Schedulers.gd").new()
@onready var Segments := preload("res://addons/gamepush/modules/Segments.gd").new()
@onready var Server := preload("res://addons/gamepush/modules/Server.gd").new()
@onready var Socials := preload("res://addons/gamepush/modules/Socials.gd").new()
@onready var System := preload("res://addons/gamepush/modules/System.gd").new()
@onready var Variables := preload("res://addons/gamepush/modules/Variables.gd").new()
@onready var Uniques := preload("res://addons/gamepush/modules/Uniques.gd").new()
@onready var Storage := preload("res://addons/gamepush/modules/Storage.gd").new()


func _ready():
	add_child(Achievements)
	add_child(Ads)
	add_child(Analytics)
	add_child(Triggers)
	add_child(App)
	add_child(AvatarGenerator)
	add_child(Channels)
	add_child(Device)
	add_child(Documents)
	add_child(Events)
	add_child(Experiments)
	add_child(Fullscreen)
	add_child(Game)
	add_child(GamesCollections)
	add_child(Images)
	add_child(Language)
	add_child(Leaderboard)
	add_child(LeaderboardScoped)
	add_child(Payments)
	add_child(Platform)
	add_child(Player)
	add_child(Players)
	add_child(Rewards)
	add_child(Schedulers)
	add_child(Segments)
	add_child(Server)
	add_child(Socials)
	add_child(System)
	add_child(Variables)
	add_child(Uniques)
	add_child(Storage)
	var timer := Timer.new()
	var is_preloader_show = false
	var ready_delay = 0.0
	is_preloader_show = ProjectSettings.get_setting("gp/config/is_preloader_show")
	ready_delay = ProjectSettings.get_setting("gp/config/ready_delay")
	if is_preloader_show:
		Ads.show_preloader()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start(ready_delay)


func _on_timer_timeout():
	Game.game_start()
