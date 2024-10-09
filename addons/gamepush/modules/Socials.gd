extends Node

var window:JavaScriptObject
var gp:JavaScriptObject

signal shared(success: bool)
signal posted(success: bool)
signal invited(success: bool)
signal joined_community(success: bool)


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		gp.socials.on("share", JavaScriptBridge.create_callback(_share))
		gp.socials.on("invite", JavaScriptBridge.create_callback(_invite))
		gp.socials.on("joinCommunity", JavaScriptBridge.create_callback(_join_community))

# Check if sharing is supported
func is_supports_share() -> bool:
	if OS.get_name() == "Web":
		return gp.socials.isSupportsShare
	push_warning("Not running on Web")
	return false

# Check if native sharing is supported
func is_supports_native_share() -> bool:
	if OS.get_name() == "Web":
		return gp.socials.isSupportsNativeShare
	push_warning("Not running on Web")
	return false
	
func share(text: String = "", url: String = "", image: String = "") -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if text != "":
			conf["text"] = text
		if url != "":
			conf["url"] = url
		if image != "":
			conf["image"] = image
		gp.socials.share(conf)
	else:
		push_warning("Not running on Web")

# Check if native posting is supported
func is_supports_native_posts() -> bool:
	if OS.get_name() == "Web":
		return gp.socials.isSupportsNativePosts
	push_warning("Not running on Web")
	return false
	
# Post text, URL, and image
func post(text: String = "", url: String = "", image: String = "") -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if text != "":
			conf["text"] = text
		if url != "":
			conf["url"] = url
		if image != "":
			conf["image"] = image
		gp.socials.post(conf)
	else:
		push_warning("Not running on Web")
	
# Check if native invites are supported
func is_supports_native_invite() -> bool:
	if OS.get_name() == "Web":
		return gp.socials.isSupportsNativeInvite
	push_warning("Not running on Web")
	return false
	
# Invite players
func invite(text: String = "") -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if text != "":
			conf["text"] = text
		gp.socials.invite(conf)
	else:
		push_warning("Not running on Web")

# Check if joining community is supported
func can_join_community() -> bool:
	if OS.get_name() == "Web":
		return gp.socials.canJoinCommunity
	push_warning("Not running on Web")
	return false
	
# Check if native community join is supported
func is_supports_native_community_join() -> bool:
	if OS.get_name() == "Web":
		return gp.socials.isSupportsNativeCommunityJoin
	push_warning("Not running on Web")
	return false

# Join community
func join_community() -> void:
	if OS.get_name() == "Web":
		gp.socials.joinCommunity()
	else:
		push_warning("Not running on Web")

# Generate a share URL with custom parameters
func make_share_url(from_id: String, gift: String) -> String:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["fromId"] = from_id
		conf["gift"] = gift
		return gp.socials.makeShareUrl(conf)
	push_warning("Not running on Web")
	return ""
	
# Retrieve share parameters from URL
func get_share_param(param: String) -> String:
	if OS.get_name() == "Web":
		return gp.socials.getShareParam(param)
	push_warning("Not running on Web")
	return ""
	
	
func _share(success:bool) -> void:
	shared.emit(success)
	
func _invite(success) -> void:
	invited.connect(success)
	
func _join_community(success) -> void:
	joined_community.emit(success)