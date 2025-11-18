extends Control

@onready var type_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/type"
@onready var format_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/format"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.documents.opened.connect(func(): GP.logger.info("open"))
	GP.documents.closed.connect(func(): GP.logger.info("close"))
	GP.documents.fetched.connect(func(a): GP.logger.info("fetch", a))
	GP.documents.error_fetch.connect(func(a): GP.logger.info("error", a,))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_open_pressed():
	GP.documents.open(type_node.text)


func _on_fetch_pressed():
	GP.documents.fetch(type_node.text, format_node.text)
