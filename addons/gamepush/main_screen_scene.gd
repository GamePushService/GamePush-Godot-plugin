@tool
extends Control

signal main_scene_data_change

var archive_name := "export_archive.zip"
var project_id := ""
var token := ""
var is_archive := false
var config = ConfigFile.new()

func _ready():
	if !ProjectSettings.has_setting("gp/config/is_preloader_show"):
		ProjectSettings.set_setting("gp/config/is_preloader_show", false)
	if !ProjectSettings.has_setting("gp/config/ready_delay"):
		ProjectSettings.set_setting("gp/config/ready_delay", 0.0)
	var err = config.load("res://addons/gamepush/config.cfg")
	if err != OK:
		push_warning(err)
	project_id = config.get_value("config", "project_id")
	token = config.get_value("config", "token")
	is_archive = config.get_value("config", "is_archive")
	archive_name = config.get_value("config", "archive_name")
	$MarginContainer/VBoxContainer/HBoxContainer/ProjectId.text = project_id
	$MarginContainer/VBoxContainer/HBoxContainer2/Token.text = token
	$MarginContainer/VBoxContainer/HBoxContainer3/NameArchive.text = archive_name
	$MarginContainer/VBoxContainer/HBoxContainer4/IsArchive.button_pressed = is_archive
	#$MarginContainer/VBoxContainer/HBoxContainer5/ShowPreload.button_pressed = is_preloader_show
	#$MarginContainer/VBoxContainer/HBoxContainer6/ReadyDelay.text = str(ready_delay)
	_config_change()
	

func _on_project_id_text_changed(new_text: String) -> void:
	project_id = new_text
	_config_change()


func _on_token_text_changed(new_text: String) -> void:
	token = new_text
	_config_change()


func _on_is_archive_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$MarginContainer/VBoxContainer/HBoxContainer3/NameArchive.editable = true
		is_archive = true
	else:
		$MarginContainer/VBoxContainer/HBoxContainer3/NameArchive.editable = false
		is_archive = false
	_config_change()


func _on_name_archive_text_changed(new_text: String) -> void:
	if new_text.ends_with(".zip"):
		archive_name = new_text
	else:
		archive_name = new_text + ".zip"
	_config_change()


func _on_show_preload_toggled(toggled_on: bool) -> void:
	pass

func _on_ready_delay_text_changed(new_text: String) -> void:
	pass
	
	
func _config_change():
	main_scene_data_change.emit()
	config.set_value("config", "project_id", project_id)
	config.set_value("config", "token", token)
	config.set_value("config", "is_archive", is_archive)
	config.set_value("config", "archive_name", archive_name)
	#config.set_value("config", "is_preloader_show", is_preloader_show)
	#config.set_value("config", "ready_delay", ready_delay)
	config.save("res://addons/gamepush/config.cfg")
