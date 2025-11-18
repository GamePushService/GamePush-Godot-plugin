extends Control

@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"
@onready var value_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/value"


func _ready():
	GP.uniques.checked.connect(_checked)
	GP.uniques.registered.connect(_registered)
	GP.uniques.register_error.connect(_register_error)
	GP.uniques.check_error.connect(_check_error)
	GP.uniques.deleted.connect(_deleted)
	GP.uniques.delete_error.connect(_delete_error)


func _checked(unique_value):
	GP.logger.info("check", unique_value)
	
func _registered(unique_value):
	GP.logger.info("registered", unique_value)
	
func _register_error(err):
	GP.logger.info("register_error", err)
	
func _check_error(err):
	GP.logger.info("check_error", err)
	
func _deleted(unique_value):
	GP.logger.info("deleted", unique_value)
	
func _delete_error(err):
	GP.logger.info("delete_error", err)
	

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_register_pressed():
	GP.uniques.register(tag_node.text, value_node.text)


func _on_get_value_pressed():
	GP.logger.info(GP.uniques.get_value(tag_node.text))


func _on_list_pressed():
	GP.logger.info(GP.uniques.list())


func _on_check_pressed():
	GP.uniques.check(tag_node.text, value_node.text)


func _on_delete_unique_pressed():
	GP.uniques.delete_unique(tag_node.text)
