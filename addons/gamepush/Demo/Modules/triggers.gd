extends Control

@onready var id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_or_tag"
@onready var id_trigger := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_trigger"


func _ready():
	GP.triggers.activated.connect(_activated)
	GP.triggers.claimed.connect(_claimed)
	GP.triggers.error_claim.connect(_error_claim)
	

func _activated(trigger):
	GP.logger.info("activated", trigger.to_dict())

func _claimed(trigger):
	GP.logger.info("claimed", trigger.to_dict())

func _error_claim(err):
	GP.logger.info("error_claim", err)


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_claim_pressed():
	GP.logger.info(await GP.triggers.claim(id_or_tag_node.text))


func _on_list_pressed():
	var result := []
	for t in GP.triggers.list():
		result.append(t.to_dict())
	GP.logger.info(result)


func _on_activated_list_pressed():
	GP.logger.info(GP.triggers.activated_list())


func _on_get_trigger_pressed():
	var result = GP.triggers.get_trigger(id_trigger.text)
	result["trigger"] = result["trigger"].to_dict()
	GP.logger.info(result)


func _on_is_trigger_activated_pressed():
	GP.logger.info(GP.triggers.is_trigger_activated(id_or_tag_node.text))
	

func _on_is_claimed_pressed():
	GP.logger.info(GP.triggers.is_claimed(id_or_tag_node.text))
