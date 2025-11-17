extends Control

@onready var url_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/url"
@onready var file_name_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/file_name"
@onready var content_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/content"
@onready var type_file_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/type_file"
@onready var player_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/player_id"
@onready var limit_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/limit"
@onready var offset_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/offset"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"
@onready var tag2_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag2"
@onready var tag3_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag3"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.files.uploaded.connect(func(arg): GP.logger.info("uploaded", arg.to_dict()))
	GP.files.error_upload.connect(func(arg): GP.logger.info("error_upload", arg))
	GP.files.loaded_content.connect(func(arg): GP.logger.info("loaded_content", arg))
	GP.files.error_load_content.connect(func(arg): GP.logger.info("error_load_content", arg))
	GP.files.choosed.connect(func(file, temp_url): GP.logger.info("choosed", file.to_dict(), temp_url))
	GP.files.error_choose.connect(func(arg): GP.logger.info("error_choose", arg))
	GP.files.fetched.connect(func(arg):
		GP.logger.info("fetched")
		var list := []
		for f in arg[0]:
			list.append(f.to_dict())
		GP.logger.info_array(list)
		GP.logger.info("canLoadMore:", arg[1])
		)
	GP.files.error_fetch.connect(func(arg): GP.logger.info("error_fetch", arg))
	GP.files.fetched_more.connect(func(arg):
		GP.logger.info("fetched_more")
		var list := []
		for f in arg[0]:
			list.append(f.to_dict())
		GP.logger.info_array(list)
		GP.logger.info("canLoadMore:", arg[1])
		)
	GP.files.error_fetch_more.connect(func(arg): GP.logger.info("error_fetch_more", arg))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_upload_pressed():
	GP.files.upload([tag_node.text, tag2_node.text, tag3_node.text])


func _on_upload_url_pressed():
	GP.files.upload_url(file_name_node.text, url_node.text, [tag_node.text, tag2_node.text, tag3_node.text])


func _on_upload_content_pressed():
	GP.files.upload_content(file_name_node.text, content_node.text, [tag_node.text, tag2_node.text, tag3_node.text])


func _on_load_сontent_pressed():
	GP.files.load_сontent(url_node.text)


func _on_choose_file_pressed():
	GP.files.choose_file(type_file_node.text)


func _on_fetch_pressed():
	var player_id = null
	var tags := []
	var limit = null
	var offset = null
	if player_id_node.text:
		player_id = player_id_node.text
	if limit_node.text:
		limit = limit_node.text
	if offset_node.text:
		offset = offset_node.text
	if tag_node.text:
		tags.append(tag_node.text)
	if tag2_node.text:
		tags.append(tag2_node.text)
	if tag3_node.text:
		tags.append(tag3_node.text)
	GP.files.fetch(player_id, tags, limit, offset)


func _on_fetch_more_pressed():
	var player_id = null
	var tags := []
	var limit = null
	var offset = null
	if player_id_node.text:
		player_id = player_id_node.text
	if limit_node.text:
		limit = limit_node.text
	if offset_node.text:
		offset = offset_node.text
	if tag_node.text:
		tags.append(tag_node.text)
	if tag2_node.text:
		tags.append(tag2_node.text)
	if tag3_node.text:
		tags.append(tag3_node.text)
	GP.files.fetch_more(player_id, tags, limit, offset)
