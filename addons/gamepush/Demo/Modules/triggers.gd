extends Control

@onready var id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_or_tag"
@onready var id_trigger := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_trigger"


func _ready():
	GP.Triggers.activated.connect(_activated)
	GP.Triggers.claimed.connect(_claimed)
	GP.Triggers.error_claim.connect(_error_claim)
	

func _activated(trigger):
	GP.Logger.info("activated", trigger.to_dict())

func _claimed(trigger):
	GP.Logger.info("claimed", trigger.to_dict())

func _error_claim(err):
	GP.Logger.info("error_claim", err)


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_claim_pressed():
	GP.Logger.info(await GP.Triggers.claim(id_or_tag_node.text))


func _on_list_pressed():
	var result := []
	for t in GP.Triggers.list():
		result.append(t.to_dict())
	GP.Logger.info(result)


func _on_activated_list_pressed():
	GP.Logger.info(GP.Triggers.activated_list())


func _on_get_trigger_pressed():
	var result = GP.Triggers.get_trigger(id_trigger.text)
	result["trigger"] = result["trigger"].to_dict()
	GP.Logger.info(result)


func _on_is_trigger_activated_pressed():
	GP.Logger.info(GP.Triggers.is_trigger_activated(id_or_tag_node.text))
	

func _on_is_claimed_pressed():
	GP.Logger.info(GP.Triggers.is_claimed(id_or_tag_node.text))
