extends Control

@onready var id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"
@onready var id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_or_tag"
@onready var progress_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/progress"


func _ready():
	GP.achievements.opened.connect(func(): GP.logger.info("open"))
	GP.achievements.closed.connect(func(): GP.logger.info("close"))
	GP.achievements.fetched.connect(func(a, b, c): 
		GP.logger.info("fetch")
		var res := []
		for ac in a:
			res.append(ac.to_dict())
		GP.logger.info(res)
		res = []
		for ac in b:
			res.append(ac.to_dict())
		GP.logger.info(res)
		res = []
		for ac in c:
			res.append(ac.to_dict())
		GP.logger.info(res)
		)
	GP.achievements.unlocked.connect(func(a): GP.logger.info("unlock", a.to_dict()))
	GP.achievements.progress.connect(func(a): GP.logger.info("progress", a.to_dict()))
	GP.achievements.error_unlock.connect(func(a): GP.logger.info("error", a))
	GP.achievements.error_progress.connect(func(a): GP.logger.info("error", a))
	GP.achievements.error_fetch.connect(func(a): GP.logger.info("error", a))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_open_pressed():
	GP.achievements.open()


func _on_fetch_pressed():
	GP.achievements.fetch()


func _on_unlock_pressed():
	GP.achievements.unlock(id_or_tag_node.text)


func _on_set_progress_pressed():
	GP.achievements.set_progress(int(progress_node.text), id_or_tag_node.text)


func _on_get_progress_pressed():
	GP.logger.info(GP.achievements.get_progress(id_or_tag_node.text))


func _on_has_pressed():
	GP.logger.info(GP.achievements.has(id_or_tag_node.text))


func _on_list_pressed():
	var list = GP.achievements.list()
	var result := []
	for a in list:
		result.append(a.to_dict())
	GP.logger.info(result)


func _on_player_achievements_list_pressed():
	var list = GP.achievements.player_achievements_list()
	var result := []
	for a in list:
		result.append(a.to_dict())
	GP.logger.info(result)


func _on_groups_list_pressed():
	var list = GP.achievements.groups_list()
	var result := []
	for a in list:
		result.append(a.to_dict())
	GP.logger.info(result)
