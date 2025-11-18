extends Control


@onready var id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id"
@onready var tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag"
@onready var key_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/key"
@onready var value_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/param"

# Called when the node enters the scene tree for the first time.
func _ready():
	GP.games_collections.opened.connect(func(): GP.logger.info("open"))
	GP.games_collections.closed.connect(func(): GP.logger.info("close"))
	GP.games_collections.fetched.connect(func(collection): GP.logger.info("fetch", collection.name))
	GP.games_collections.error_fetch.connect(func(): GP.logger.info("error fetch"))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_open_pressed():
	var d := { key_node.text: value_node.text }
	GP.games_collections.open(tag_node.text, int(id_node.text), d)


func _on_fetch_pressed():
	GP.games_collections.fetch(tag_node.text, int(id_node.text))
