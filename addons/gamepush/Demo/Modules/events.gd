extends Control


@onready var id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_or_tag"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.events.joined.connect(func(event, player_event): GP.logger.info("join", event.to_dict(), player_event.to_dict()))
	GP.events.error_join.connect(func(err): GP.logger.info("error", err))



func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_join_pressed():
	GP.events.join(id_or_tag_node.text)


func _on_list_pressed():
	var list := []
	for e in GP.events.list():
		list.append(e.to_dict())
	GP.logger.info_array(list)


func _on_active_list_pressed():
	var list := []
	for e in GP.events.active_list():
		list.append(e.to_dict())
	GP.logger.info_array(list)


func _on_get_event_pressed():
	GP.logger.info(GP.events.get_event(id_or_tag_node.text).to_dict())


func _on_has_pressed():
	GP.logger.info(GP.events.has(id_or_tag_node.text))


func _on_is_joined_pressed():
	GP.logger.info(GP.events.is_joined(id_or_tag_node.text))
