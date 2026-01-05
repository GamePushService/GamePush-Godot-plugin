extends Control

@onready var channel_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/channel_id"
@onready var text_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/text"
@onready var tag1_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag1"
@onready var tag2_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag2"
@onready var tag3_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag3"
@onready var message_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/message_id"
@onready var limit_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/limit"
@onready var offset_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/offset"
@onready var player_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/player_id"
@onready var template_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/template"
@onready var capacity_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/capacity"
@onready var name_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/name"
@onready var description_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/description"
@onready var search_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/search"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.channels.event_message.connect(func(message): GP.logger.info("event_message", message.to_dict()))
	GP.channels.message_received.connect(func(message): GP.logger.info("message_received", message.to_dict()))
	GP.channels.message_sent.connect(func(message): GP.logger.info("message_sent", message.to_dict()))
	GP.channels.message_error.connect(func(error): GP.logger.info("message_error", error))
	GP.channels.message_edited.connect(func(message): GP.logger.info("message_edited", message.to_dict()))
	GP.channels.error_edit_message.connect(func(error): GP.logger.info("error_edit_message", error))
	GP.channels.event_edit_message.connect(func(message): GP.logger.info("event_edit_message", message.to_dict()))
	GP.channels.message_deleted.connect(func(): GP.logger.info("message_deleted"))
	GP.channels.event_delete_message.connect(func(message): GP.logger.info("event_delete_message", message.to_dict()))
	GP.channels.error_delete_message.connect(func(err): GP.logger.info("error_delete_message", err))
	GP.channels.messages_fetched.connect(func(result):
		var res := {}
		res["items"] = []
		res["can_load_more"] = result["can_load_more"]
		for i in result["items"]:
			res["items"].append(i.to_dict())
		GP.logger.info("messages_fetched", res)
		)
	GP.channels.personal_messages_fetched.connect(func(result):
		var res := {}
		res["items"] = []
		res["can_load_more"] = result["can_load_more"]
		for i in result["items"]:
			res["items"].append(i.to_dict())
		GP.logger.info("personal_messages_fetched", res)
		)
	GP.channels.feed_messages_fetched.connect(func(result):
		var res := {}
		res["items"] = []
		res["can_load_more"] = result["can_load_more"]
		for i in result["items"]:
			res["items"].append(i.to_dict())
		GP.logger.info("feed_messages_fetched", res)
		)
	GP.channels.more_personal_messages_fetched.connect(func(result):
		var res := {}
		res["items"] = []
		res["can_load_more"] = result["can_load_more"]
		for i in result["items"]:
			res["items"].append(i.to_dict())
		GP.logger.info("more_personal_messages_fetched", res)
		)
	GP.channels.more_feed_messages_fetched.connect(func(result):
		var res := {}
		res["items"] = []
		res["can_load_more"] = result["can_load_more"]
		for i in result["items"]:
			res["items"].append(i.to_dict())
		GP.logger.info("more_feed_messages_fetched", res)
		)
	GP.channels.error_fetch_messages.connect(func(err): GP.logger.info("error_fetch_messages", err))
	GP.channels.more_messages_fetched.connect(func(result):
		var res := {}
		res["items"] = []
		res["can_load_more"] = result["can_load_more"]
		for i in result["items"]:
			res["items"].append(i.to_dict())
		GP.logger.info("fetched_more_messages", res)
		)
	GP.channels.error_fetch_more_messages.connect(func(err): GP.logger.info("error_fetch_more_messages", err))
	GP.channels.channel_created.connect(func(channel): GP.logger.info("channel_created", channel.to_dict()))
	GP.channels.error_create_channel.connect(func(err): GP.logger.info("error_create_channel", err))
	GP.channels.channel_updated.connect(func(channel): GP.logger.info("channel_updated", channel.to_dict()))
	GP.channels.error_update_channel.connect(func(err): GP.logger.info("error_update_channel", err))
	GP.channels.channel_deleted.connect(func(success): GP.logger.info("channel_deleted, success", success))
	GP.channels.error_delete_channel.connect(func(err): GP.logger.info("error_delete_channel", err))
	GP.channels.event_channel_updated.connect(func(channel): GP.logger.info("event_channel_updated", channel.to_dict()))
	GP.channels.event_channel_deleted.connect(func(channel_id): GP.logger.info("event_channel_deleted", channel_id))
	GP.channels.channel_fetched.connect(func(channel): GP.logger.info("channel_fetched", channel.to_dict()))
	GP.channels.fetch_channel_error.connect(func(err): GP.logger.info("fetch_channel_error", err))
	GP.channels.channels_fetched.connect(func(channels, can_load_more):
		var res := []
		for c in channels:
			res.append(c.to_dict())
		GP.logger.info("channels_fetched", res, can_load_more))
	GP.channels.fetch_channels_error.connect(func(err): GP.logger.info("fetch_channels_error", err))
	GP.channels.more_channels_fetched.connect(func(channels, can_load_more): 
		var res := []
		for c in channels:
			res.append(c.to_dict())
		GP.logger.info("more_channels_fetched", res, can_load_more))
	GP.channels.fetch_more_channels_error.connect(func(err): GP.logger.info("fetch_more_channels_error", err))
	GP.channels.chat_opened.connect(func(): GP.logger.info("chat_opened"))
	GP.channels.chat_closed.connect(func(): GP.logger.info("chat_closed"))
	GP.channels.chat_error.connect(func(err): GP.logger.info("chat_error", err))
	GP.channels.joined.connect(func(success): GP.logger.info("joined, success:", success))
	GP.channels.error_join.connect(func(err): GP.logger.info("error_join", err))
	GP.channels.event_joined.connect(func(member): GP.logger.info("event_joined", member))
	GP.channels.join_request_received.connect(func(join_request): GP.logger.info("join_request_received", join_request))
	GP.channels.cancel_joined.connect(func(): GP.logger.info("cancel_joined"))
	GP.channels.cancel_join_error.connect(func(err): GP.logger.info("cancel_join_error", err))
	GP.channels.event_cancel_join.connect(func(join_request): GP.logger.info("event_cancel_join", join_request))
	GP.channels.leave_successful.connect(func(): GP.logger.info("leave_successful"))
	GP.channels.leave_error.connect(func(err): GP.logger.info("leave_error", err))
	GP.channels.leave_event.connect(func(member): GP.logger.info("leave_event", member))
	GP.channels.kick_successful.connect(func(): GP.logger.info("kick_successful"))
	GP.channels.kick_error.connect(func(err): GP.logger.info("kick_error", err))
	GP.channels.leave_event.connect(func(member): GP.logger.info("leave_event", member))
	GP.channels.members_fetched.connect(func(members, can_load_more): 
		var membs := []
		for m in members:
			membs.append(m.to_dict())
		GP.logger.info("members_fetched", membs, "can_load_more:", can_load_more))
	GP.channels.fetch_members_error.connect(func(err): GP.logger.info("fetch_members_error", err))
	GP.channels.fetch_more_members_success.connect(func(members, can_load_more): GP.logger.info("fetch_more_members_success", members, "can_load_more:", can_load_more))
	GP.channels.fetch_more_members_error.connect(func(err): GP.logger.info("fetch_more_members_error", err))
	GP.channels.mute_success.connect(func(): GP.logger.info("mute_success"))
	GP.channels.mute_error.connect(func(err): GP.logger.info("mute_error", err))
	GP.channels.event_mute.connect(func(mute): GP.logger.info("event_mute", mute))
	GP.channels.unmute_success.connect(func(): GP.logger.info("unmute_success"))
	GP.channels.unmute_error.connect(func(err): GP.logger.info("unmute_error", err))
	GP.channels.event_unmute.connect(func(unmute): GP.logger.info("event_unmute", unmute))
	GP.channels.sent_invite.connect(func(): GP.logger.info("sent_invite"))
	GP.channels.sent_invite_error.connect(func(err): GP.logger.info("sent_invite_error", err))
	GP.channels.event_invite.connect(func(invite): GP.logger.info("event_invite", invite))
	GP.channels.canceled_invite.connect(func(): GP.logger.info("canceled_invite"))
	GP.channels.cancel_invite_error.connect(func(err): GP.logger.info("cancel_invite_error", err))
	GP.channels.event_cancel_invite.connect(func(invite): GP.logger.info("event_cancel_invite", invite))
	GP.channels.accepted_invite.connect(func(): GP.logger.info("accepted_invite"))
	GP.channels.error_accept_invite.connect(func(err): GP.logger.info("error_accept_invite", err))
	GP.channels.rejected_invite.connect(func(): GP.logger.info("rejected_invite"))
	GP.channels.error_reject_invite.connect(func(err): GP.logger.info("error_reject_invite", err))
	GP.channels.event_reject_invite.connect(func(invite): GP.logger.info("event_reject_invite", invite))
	GP.channels.fetched_invites.connect(func(result): GP.logger.info("fetched_invites", result))
	GP.channels.error_fetch_invites.connect(func(err): GP.logger.info("error_fetch_invites", err))
	GP.channels.fetched_more_invites.connect(func(result): GP.logger.info("fetched_more_invites", result))
	GP.channels.error_fetch_more_invites.connect(func(err): GP.logger.info("error_fetch_more_invites", err))
	GP.channels.fetched_channel_invites.connect(func(result): GP.logger.info("fetched_channel_invites", result))
	GP.channels.error_fetch_channel_invites.connect(func(err): GP.logger.info("error_fetch_channel_invites", err))
	GP.channels.fetched_more_channel_invites.connect(func(result): GP.logger.info("fetched_more_channel_invites", result))
	GP.channels.error_fetch_more_channel_invites.connect(func(err): GP.logger.info("error_fetch_more_channel_invites", err))
	GP.channels.fetched_sent_invites.connect(func(result): GP.logger.info("fetched_sent_invites", result))
	GP.channels.error_fetch_sent_invites.connect(func(err): GP.logger.info("error_fetch_sent_invites", err))
	GP.channels.fetched_more_sent_invites.connect(func(result): GP.logger.info("fetched_more_sent_invites", result))
	GP.channels.error_fetch_more_sent_invites.connect(func(err): GP.logger.info("error_fetch_more_sent_invites", err))
	
	GP.channels.join_request_accepted.connect(func(): GP.logger.info("join_request_accepted"))
	GP.channels.error_accept_join_request.connect(func(err): GP.logger.info("error_accept_join_request", err))
	GP.channels.join_request_rejected.connect(func(): GP.logger.info("join_request_rejected"))
	GP.channels.error_reject_join_request.connect(func(err): GP.logger.info("error_reject_join_request", err))
	GP.channels.event_reject_join_request.connect(func(res): GP.logger.info("event_reject_join_request", res))
	GP.channels.fetched_join_requests.connect(func(res): GP.logger.info("fetched_join_requests", res))
	GP.channels.error_fetch_join_requests.connect(func(err): GP.logger.info("error_fetch_join_requests", err))
	GP.channels.fetched_more_join_requests.connect(func(res): GP.logger.info("fetched_more_join_requests", res))
	GP.channels.error_fetch_more_join_requests.connect(func(err): GP.logger.info("error_fetch_more_join_requests", err))
	GP.channels.fetched_sent_join_requests.connect(func(res): GP.logger.info("fetched_join_sent_requests", res))
	GP.channels.error_fetch_sent_join_requests.connect(func(err): GP.logger.info("error_fetch_join_sent_requests", err))
	GP.channels.fetched_more_sent_join_requests.connect(func(res): GP.logger.info("fetched_more_sent_join_requests", res))
	GP.channels.error_fetch_more_sent_join_requests.connect(func(err): GP.logger.info("error_fetch_more_sent_join_requests", err))
	
	
	

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")

#region Panel1

func _on_join_pressed():
	GP.channels.join(int(channel_id_node.text), $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/password.text)


func _on_leave_pressed():
	GP.channels.leave(int(channel_id_node.text))


func _on_send_message_pressed():
	GP.channels.send_message(int(channel_id_node.text), text_node.text)
#endregion

#region channels 

func _on_create_channel_pressed():
	var channel := {}
	channel["template"] = template_node.text
	var tags := []
	if tag1_node.text:
		tags.append(tag1_node.text)
	if tag2_node.text:
		tags.append(tag2_node.text)
	if tag3_node.text:
		tags.append(tag3_node.text)
	if tags:
		channel.tags = tags
	if capacity_node.text:
		channel.capacity = int(capacity_node.text)
	if name_node.text:
		channel.name = name_node.text
	if description_node.text:
		channel.description = description_node.text
	channel["private"] = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/private.button_pressed
	channel["visible"] = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/visible.button_pressed
	channel["password"] = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/password.text
	GP.channels.create_channel(channel)


func _on_update_channel_pressed():
	var channel := {}
	channel.channel_id = int(channel_id_node.text)
	var tags := []
	if tag1_node.text:
		tags.append(tag1_node.text)
	if tag2_node.text:
		tags.append(tag2_node.text)
	if tag3_node.text:
		tags.append(tag3_node.text)
	if tags:
		channel.tags = tags
	if capacity_node.text:
		channel.capacity = int(capacity_node.text)
	if name_node.text:
		channel.name = name_node.text
	if description_node.text:
		channel.description = description_node.text
	channel.private = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/private.button_pressed
	channel.visible = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/visible.button_pressed
	channel.password = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/password.text
	if $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/owner_id.text:
		channel.owner_id = int($MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/owner_id.text)
	GP.channels.update_channel(channel)


func _on_delete_channel_pressed():
	GP.channels.delete_channel(int(channel_id_node.text))


func _on_fetch_channel_pressed():
	GP.channels.fetch_channel(int(channel_id_node.text))


func _on_fetch_channels_pressed():
	GP.channels.fetch_channels([int($MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/ids.text),
	 int($MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/ids2.text),
	 int($MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/ids3.text) ],
	 [tag1_node.text, tag2_node.text, tag3_node.text], search_node.text, $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/onlyJoined.button_pressed,
	 $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/onlyOwned.button_pressed, int(limit_node.text), int(offset_node.text))



func _on_fetch_more_channels_pressed():
	GP.channels.fetch_more_channels(int(channel_id_node.text), [tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))
#endregion

#region chats

func _on_open_chat_pressed():
		
	GP.channels.open_chat(int(channel_id_node.text),
	 [tag1_node.text, tag2_node.text, tag3_node.text])


func _on_is_main_chat_enabled_pressed():
	GP.logger.info(GP.channels.is_main_chat_enabled())


func _on_main_chat_id_pressed():
	GP.logger.info(GP.channels.main_chat_id())


func _on_open_personal_chat_pressed():
	GP.channels.open_personal_chat(int(player_id_node.text), 
	[tag1_node.text, tag2_node.text, tag3_node.text])


func _on_open_feed_pressed():
	GP.channels.open_feed(int(player_id_node.text), 
	[tag1_node.text, tag2_node.text, tag3_node.text])
#endregion

#region Members


func _on_cancel_join_pressed():
	GP.channels.cancel_join(int(channel_id_node.text))


func _on_kick_pressed():
	GP.channels.kick(int(channel_id_node.text), int(player_id_node.text))


func _on_fetch_members_pressed():
	GP.channels.fetch_members(int(channel_id_node.text))


func _on_fetch_more_members_pressed():
	GP.channels.fetch_more_members(int(channel_id_node.text))


func _on_mute_pressed():
	GP.channels.mute(int(channel_id_node.text), int(player_id_node.text))


func _on_unmute_pressed():
	GP.channels.unmute(int(channel_id_node.text), int(player_id_node.text))

#endregion

#region messages

func _on_send_personal_message_2_pressed():
	GP.channels.send_personal_message(int(player_id_node.text), text_node.text,
	[tag1_node.text, tag2_node.text, tag3_node.text])


func _on_send_feed_message_pressed():
	GP.channels.send_feed_message(int(player_id_node.text), text_node.text,
	[tag1_node.text, tag2_node.text, tag3_node.text])


func _on_edit_message_pressed():
	GP.channels.edit_message(message_id_node.text, text_node.text)


func _on_delete_message_pressed():
	GP.channels.delete_message(message_id_node.text)


func _on_fetch_messages_pressed():
	GP.channels.fetch_messages(int(channel_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text), int(offset_node.text))


func _on_fetch_personal_messages_pressed():
	GP.channels.fetch_personal_messages(int(player_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))


func _on_fetch_feed_messages_pressed():
	GP.channels.fetch_feed_messages(int(player_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text), int(offset_node.text))


func _on_fetch_more_messages_pressed():
	GP.channels.fetch_more_messages(int(channel_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))


func _on_fetch_more_personal_messages_pressed():
	GP.channels.fetch_more_personal_messages(int(player_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))


func _on_fetch_more_feed_messages_pressed():
	GP.channels.fetch_more_feed_messages(int(player_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))
	
#endregion

#region Invites

func _on_send_invite_pressed():
	GP.channels.send_invite(int(channel_id_node.text), int(player_id_node.text))


func _on_cancel_invite_pressed():
	GP.channels.cancel_invite(int(channel_id_node.text), int(player_id_node.text))


func _on_accept_invite_pressed():
	GP.channels.accept_invite(int(channel_id_node.text))


func _on_reject_invite_pressed():
	GP.channels.reject_invite(int(channel_id_node.text))


func _on_fetch_invites_pressed():
	GP.channels.fetch_invites(int(limit_node.text), int(offset_node.text))


func _on_fetch_more_invites_pressed():
	GP.channels.fetch_more_invites(int(limit_node.text))


func _on_fetch_channel_invites_pressed():
	GP.channels.fetch_channel_invites(int(channel_id_node.text), int(limit_node.text), int(offset_node.text))


func _on_fetch_more_channel_invites_pressed():
	GP.channels.fetch_more_channel_invites(int(channel_id_node.text), int(limit_node.text))


func _on_fetch_sent_invites_pressed():
	GP.channels.fetch_sent_invites(int(limit_node.text), int(offset_node.text))


func _on_fetch_more_sent_invites_pressed():
	GP.channels.fetch_more_sent_invites(int(limit_node.text))
#endregion

#region Requests

func _on_accept_join_request_pressed():
	GP.channels.accept_join_request(int(channel_id_node.text), int(player_id_node.text))


func _on_reject_join_request_pressed():
	GP.channels.reject_join_request(int(channel_id_node.text), int(player_id_node.text))


func _on_fetch_join_requests_pressed():
	GP.channels.fetch_join_requests(int(channel_id_node.text), int(limit_node.text), int(offset_node.text))


func _on_fetch_more_join_requests_pressed():
	GP.channels.fetch_more_join_requests(int(channel_id_node.text), int(limit_node.text))


func _on_fetch_sent_join_requests_pressed():
	GP.channels.fetch_sent_join_requests(int(limit_node.text), int(offset_node.text))


func _on_fetch_more_sent_join_requests_pressed():
	GP.channels.fetch_more_sent_join_requests(int(limit_node.text))
	
#endregion
