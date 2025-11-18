extends Control


func _ready():
	GP.Sounds.muted.connect(func():
		GP.Logger.info("muted", AudioServer.get_bus_name(0))
		AudioServer.set_bus_mute(0, true)
	)
	GP.Sounds.unmuted.connect(func(): 
		GP.Logger.info("unmuted", AudioServer.get_bus_name(0))
		AudioServer.set_bus_mute(0, false)
	)
	GP.Sounds.muted_sfx.connect(func():
		GP.Logger.info("muted_sfx", AudioServer.get_bus_name(1))
		AudioServer.set_bus_mute(1, true)
	)
	GP.Sounds.muted_music.connect(func():
		GP.Logger.info("muted_music", AudioServer.get_bus_name(2))
		AudioServer.set_bus_mute(2, true)
	)
	GP.Sounds.unmuted_sfx.connect(func():
		GP.Logger.info("unmuted_sfx", AudioServer.get_bus_name(1))
		AudioServer.set_bus_mute(1, false)
	)
	GP.Sounds.unmuted_music.connect(func():
		GP.Logger.info("unmuted_music", AudioServer.get_bus_name(2))
		AudioServer.set_bus_mute(2, false)
	)
	GP.Sounds.unmute()


func _on_is_muted_pressed() -> void:
	GP.Logger.info(GP.Sounds.is_muted())


func _on_is_sfx_muted_pressed() -> void:
	GP.Logger.info(GP.Sounds.is_sfx_muted())


func _on_is_music_muted_pressed() -> void:
	GP.Logger.info(GP.Sounds.is_music_muted())


func _on_mute_pressed() -> void:
	GP.Sounds.mute()


func _on_unmute_pressed() -> void:
	GP.Sounds.unmute()


func _on_mute_sfx_pressed() -> void:
	GP.Sounds.mute_sfx()


func _on_unmute_sfx_pressed() -> void:
	GP.Sounds.unmute_sfx()


func _on_mute_music_pressed() -> void:
	GP.Sounds.mute_music()


func _on_unmute_music_pressed() -> void:
	GP.Sounds.unmute_music()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")
