extends Control


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_type_pressed():
	GP.logger.info(GP.platform.type())


func _on_has_integrated_auth_pressed():
	GP.logger.info(GP.platform.has_integrated_auth())


func _on_is_logout_available_pressed():
	GP.logger.info(GP.platform.is_logout_available())


func _on_is_external_links_allowed_pressed():
	GP.logger.info(GP.platform.is_external_links_allowed())


func _on_is_secret_code_auth_available_pressed():
	GP.logger.info(GP.platform.is_secret_code_auth_available())


func _on_get_sdk_pressed():
	GP.logger.info(GP.platform.get_SDK().gp.platform.type)


func _on_get_native_sdk_pressed():
	GP.logger.info(GP.platform.get_native_SDK())
