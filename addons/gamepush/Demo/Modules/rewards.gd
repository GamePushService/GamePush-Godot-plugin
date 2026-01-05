extends Control

@onready var id_or_tag_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/id_or_tag"

# Called when the node enters the scene tree for the first time.
func _ready():
	GP.rewards.reward_accepted.connect(func(reward, player_reward): GP.logger.info("accepted"))
	GP.rewards.reward_given.connect(func(reward, player_reward): GP.logger.info("given"))
	GP.rewards.reward_error.connect(func(err): GP.logger.info("reward_error", err))
	GP.rewards.reward_accept_error.connect(func(err): GP.logger.info("reward_accept_error", err))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_give_pressed():
	var result := []
	var res = await GP.rewards.give(id_or_tag_node.text)
	for r in res:
		result.append(r.to_dict())
	GP.logger.info(result)


func _on_accept_pressed():
	var result := []
	var res = await GP.rewards.accept(id_or_tag_node.text)
	for r in res:
		result.append(r.to_dict())
	GP.logger.info(result)


func _on_list_pressed():
	var res := []
	for r in GP.rewards.list():
		res.append(r.to_dict())
	GP.logger.info(res)


func _on_given_list_pressed():
	var res := []
	for r in GP.rewards.given_list():
		res.append(r.to_dict())
	GP.logger.info(res)


func _on_get_reward_pressed():
	var res := []
	for r in GP.rewards.get_reward(id_or_tag_node.text):
		res.append(r.to_dict())
	GP.logger.info(res)


func _on_has_pressed():
	GP.logger.info(GP.rewards.has(id_or_tag_node.text))



func _on_has_accepted_pressed():
	GP.logger.info(GP.rewards.has_accepted(id_or_tag_node.text))



func _on_has_unaccepted_pressed():
	GP.logger.info(GP.rewards.has_unaccepted(id_or_tag_node.text))
