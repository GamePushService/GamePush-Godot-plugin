extends Control

func _ready():
	GP.app.review_requested.connect(func(success, rating, error): GP.logger.info("review_requested", success, rating, error))
	GP.app.shortcut_added.connect(func(arg): GP.logger.info(arg))


func _on_title_pressed():
	GP.logger.info(GP.App.title())


func _on_description_pressed():
	GP.logger.info(GP.App.description())


func _on_image_pressed():
	GP.logger.info(GP.App.image())


func _on_url_pressed():
	GP.logger.info(GP.App.url())


func _on_request_review_pressed():
	GP.App.request_review()
	


func _on_can_request_review_pressed():
	GP.logger.info(GP.App.can_request_review())
	

func _on_is_already_reviewed_pressed():
	GP.logger.info(GP.App.is_already_reviewed())


func _on_add_shortcut_pressed():
	GP.App.add_shortcut()


func _on_can_add_shortcut_pressed():
	GP.logger.info(GP.App.can_add_shortcut())


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")
