extends Control

@onready var countdown_node := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/show_countdown_overlay

func _ready():
	GP.ads.start.connect(_on_signal_start)
	GP.ads.close.connect(_on_signal_close)
	GP.ads.fullscreen_start.connect(func(): GP.logger.info("fullscreen start"))
	GP.ads.fullscreen_close.connect(func(arg): GP.logger.info("fullscreen close", arg))
	GP.ads.preloader_start.connect(func(): GP.logger.info("preloader start"))
	GP.ads.preloader_close.connect(func(arg): GP.logger.info("preloader close", arg))
	GP.ads.rewarded_reward.connect(func(): GP.logger.info("rewarded reward"))
	GP.ads.rewarded_start.connect(func(): GP.logger.info("rewarded start"))
	GP.ads.rewarded_close.connect(func(arg): GP.logger.info("rewarded close", arg))
	GP.ads.sticky_start.connect(func(): GP.logger.info("sticky start"))
	GP.ads.sticky_close.connect(func(): GP.logger.info("sticky close"))
	GP.ads.sticky_render.connect(func(): GP.logger.info("sticky render"))
	GP.ads.sticky_refresh.connect(func(): GP.logger.info("sticky refresh"))


func _on_is_adblock_enabled_pressed():
	GP.logger.info(GP.ads.is_adblock_enabled())


func _on_is_sticky_available_pressed():
	GP.logger.info(GP.ads.is_sticky_available())


func _on_is_fullscreen_available_pressed():
	GP.logger.info(GP.ads.is_fullscreen_available())


func _on_is_rewarded_available_pressed():
	GP.logger.info(GP.ads.is_rewarded_available())


func _on_signal_start():
	GP.logger.info("start")
	
func _on_signal_close(success):
	GP.logger.info("close")
	GP.logger.info("success: ", success)


func _on_show_fullscreen_pressed():
	GP.ads.show_fullscreen(countdown_node.button_pressed)


func _on_show_rewarded_video_pressed():
	GP.ads.show_rewarded_video(countdown_node.button_pressed)


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_show_preloader_pressed():
	GP.ads.show_preloader()


func _on_is_sticky_playing_pressed():
	GP.logger.info(GP.ads.is_sticky_playing())


func _on_is_fullscreen_playing_pressed():
	GP.logger.info(GP.ads.is_fullscreen_playing())


func _on_is_rewarded_playing_pressed():
	GP.logger.info(GP.ads.is_rewarded_playing())


func _on_is_preloader_playing_pressed():
	GP.logger.info(GP.ads.is_preloader_playing())


func _on_is_countdown_overlay_enabled_pressed():
	GP.logger.info(GP.ads.is_countdown_overlay_enabled())


func _on_is_rewarded_failed_overlay_enabled_pressed():
	GP.logger.info(GP.ads.is_rewarded_failed_overlay_enabled())


func _on_show_sticky_pressed():
	GP.ads.show_sticky()


func _on_can_show_fullscreen_before_game_play_pressed():
	GP.logger.info(GP.ads.can_show_fullscreen_before_game_play())


func _on_refresh_sticky_pressed():
	GP.ads.refresh_sticky()


func _on_close_sticky_pressed():
	GP.ads.close_sticky()


func _on_is_preloader_available_pressed() -> void:
	GP.logger.info(GP.ads.is_preloader_available())
