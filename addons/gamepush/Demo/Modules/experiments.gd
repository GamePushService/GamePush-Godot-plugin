extends Control


@onready var cohort_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/cohort"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"



func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_map_pressed():
	GP.logger.info(GP.experiments.map())


func _on_has_pressed():
	GP.logger.info(GP.experiments.has(tag_node.text, cohort_node.text))
