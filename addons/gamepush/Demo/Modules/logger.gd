extends Control

@onready var text_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/text"
@onready var text_node2 := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/text2"


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_info_pressed():
	GP.logger.info(text_node.text, text_node2.text)


func _on_warn_pressed():
	GP.logger.warn(text_node.text, text_node2.text)


func _on_error_pressed():
	GP.logger.error(text_node.text, text_node2.text)


func _on_log_pressed():
	GP.logger.log(text_node.text, text_node2.text)


func _on_info_array_pressed():
	GP.logger.info_array([text_node.text, text_node2.text])


func _on_warn_array_pressed():
	GP.logger.warn_array([text_node.text, text_node2.text])


func _on_error_array_pressed():
	GP.logger.error_array([text_node.text, text_node2.text])
