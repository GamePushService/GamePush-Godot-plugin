extends Control


func _ready():
	GP.sounds.muted.connect(func():
		GP.logger.info("muted", AudioServer.get_bus_name(0))
		AudioServer.set_bus_mute(0, true)
	)
	GP.sounds.unmuted.connect(func(): 
		GP.logger.info("unmuted", AudioServer.get_bus_name(0))
		AudioServer.set_bus_mute(0, false)
	)
	GP.sounds.muted_sfx.connect(func():
		GP.logger.info("muted_sfx", AudioServer.get_bus_name(1))
		AudioServer.set_bus_mute(1, true)
	)
	GP.sounds.muted_music.connect(func():
		GP.logger.info("muted_music", AudioServer.get_bus_name(2))
		AudioServer.set_bus_mute(2, true)
	)
	GP.sounds.unmuted_sfx.connect(func():
		GP.logger.info("unmuted_sfx", AudioServer.get_bus_name(1))
		AudioServer.set_bus_mute(1, false)
	)
	GP.sounds.unmuted_music.connect(func():
		GP.logger.info("unmuted_music", AudioServer.get_bus_name(2))
		AudioServer.set_bus_mute(2, false)
	)
	GP.sounds.unmute()


func _on_is_muted_pressed() -> void:
	GP.logger.info(GP.sounds.is_muted())


func _on_is_sfx_muted_pressed() -> void:
	GP.logger.info(GP.sounds.is_sfx_muted())


func _on_is_music_muted_pressed() -> void:
	GP.logger.info(GP.sounds.is_music_muted())


func _on_mute_pressed() -> void:
	GP.sounds.mute()


func _on_unmute_pressed() -> void:
	GP.sounds.unmute()


func _on_mute_sfx_pressed() -> void:
	GP.sounds.mute_sfx()


func _on_unmute_sfx_pressed() -> void:
	GP.sounds.unmute_sfx()


func _on_mute_music_pressed() -> void:
	GP.sounds.mute_music()


func _on_unmute_music_pressed() -> void:
	GP.sounds.unmute_music()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")
