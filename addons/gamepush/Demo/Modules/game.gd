extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.game.paused.connect(func(): GP.logger.info("pause"))
	GP.game.resumed.connect(func(): GP.logger.info("resume"))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_is_paused_pressed():
	GP.logger.info(GP.game.is_paused())


func _on_pause_pressed():
	GP.game.pause()


func _on_resume_pressed():
	GP.game.resume()


func _on_game_start_pressed():
	GP.game.game_start()


func _on_gameplay_start_pressed():
	GP.game.gameplay_start()


func _on_gameplay_stop_pressed():
	GP.game.gameplay_stop()
