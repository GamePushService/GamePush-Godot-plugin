extends Control



func _ready():
	GP.fullscreen.opened.connect(func(): GP.logger.info("open"))
	GP.fullscreen.closed.connect(func(): GP.logger.info("close"))
	GP.fullscreen.changed.connect(func(): GP.logger.info("change"))
	
	
func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_open_pressed():
	GP.fullscreen.open()


func _on_close_pressed():
	GP.fullscreen.close()


func _on_toggle_pressed():
	GP.fullscreen.toggle()


func _on_is_enabled_pressed():
	GP.logger.info(GP.fullscreen.is_enabled())
